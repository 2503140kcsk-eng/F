module

public import Mathlib.Combinatorics.SimpleGraph.Basic
public import Mathlib.Data.Nat.Basic
public import Mathlib.Tactic.GCongr
public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.Positivity
public import HakuiKoyori.Number

@[expose] public section

namespace HakuiKoyori

/-- Iterate a natural-number endofunction exactly steps times. -/
def natIterate (f : Nat → Nat) : Nat → Nat → Nat
  | 0, seed => seed
  | steps + 1, seed => f (natIterate f steps seed)

/-- Knuth up-arrow hierarchy: rank 0 is multiplication and rank 1 is exponentiation. -/
def knuthUpArrow (base : Nat) : Nat → Nat → Nat
  | 0, right => base * right
  | rank + 1, right => natIterate (knuthUpArrow base rank) right 1

/-- The common starting value 10 up-arrow rank 10 applied to 10. -/
def gardenSeed : Nat := knuthUpArrow 10 10 10

/-- The finite running maximum of f on the initial segment {0,...,n}. -/
def prefixMaximum (f : Nat → Nat) : Nat → Nat
  | 0 => f 0
  | n + 1 => max (prefixMaximum f n) (f (n + 1))

theorem le_prefixMaximum (f : Nat → Nat) (n : Nat) :
    f n ≤ prefixMaximum f n := by
  induction n with
  | zero =>
      simp [prefixMaximum]
  | succ n ih =>
      exact le_max_right _ _

theorem prefixMaximum_monotone (f : Nat → Nat) :
    Monotone (prefixMaximum f) := by
  intro a b hab
  induction hab with
  | refl =>
      exact le_rfl
  | @step b hab ih =>
      exact le_trans ih (le_max_left _ _)

/-- A reagent set is represented by its characteristic function on Fin n. -/
abbrev ReagentSet (n : Nat) := Fin n → Bool

/-- Convert a characteristic function into its corresponding finite subset. -/
def reagentSubset {n : Nat} (A : ReagentSet n) : Finset (Fin n) :=
  Finset.univ.filter (fun i => A i = true)

@[simp]
theorem mem_reagentSubset {n : Nat} (A : ReagentSet n) (i : Fin n) :
    i ∈ reagentSubset A ↔ A i = true := by
  simp [reagentSubset]

/--
The Koyori laboratory graph Q_n. Its vertices are characteristic functions
for all subsets of Fin n; two vertices are adjacent exactly when one
ingredient changes.
-/
def koyoriHypercube (n : Nat) : SimpleGraph (ReagentSet n) where
  Adj A B := A ≠ B ∧
    (reagentSubset A \ reagentSubset B).card +
      (reagentSubset B \ reagentSubset A).card = 1
  symm := by
    constructor
    intro A B h
    exact ⟨h.1.symm, by simpa [Nat.add_comm] using h.2⟩
  loopless := by
    constructor
    intro A h
    exact h.1 rfl

/-- All spanning subgraphs of the finite Koyori hypercube. -/
abbrev KoyoriSubgraphSpace (n : Nat) :=
  {G : SimpleGraph (ReagentSet n) // G ≤ koyoriHypercube n}

/--
The number of graph experiments: the cardinality of all spanning subgraphs
of Q_n. This is a natural number because the vertex and graph types are finite.
-/
noncomputable def graphSetCount (n : Nat) : Nat := by
  classical
  exact Fintype.card (KoyoriSubgraphSpace n)

/-- Running maximum of the finite graph/set experiment counts. -/
noncomputable def graphSetPrefixMaximum : Nat → Nat :=
  prefixMaximum graphSetCount

theorem graphSetCount_le_prefixMaximum (n : Nat) :
    graphSetCount n ≤ graphSetPrefixMaximum n :=
  le_prefixMaximum graphSetCount n

/--
The Koyori Spark transform combines the finite running maximum of the
Garden function, the running maximum of the graph/subgraph counts, and
the current stage index.
-/
noncomputable def koyoriSparkTransform (gardenFunction : Nat → Nat) (n : Nat) : Nat :=
  2 ^ (prefixMaximum gardenFunction n + graphSetPrefixMaximum n + n + 3)

/-- Every Spark step strictly exceeds the Garden function at that input. -/
theorem koyoriSparkTransform_gt (gardenFunction : Nat → Nat) (n : Nat) :
    gardenFunction n < koyoriSparkTransform gardenFunction n := by
  let exponent :=
    prefixMaximum gardenFunction n + graphSetPrefixMaximum n + n + 2
  have hmax : gardenFunction n ≤ prefixMaximum gardenFunction n :=
    le_prefixMaximum gardenFunction n
  have hmargin : gardenFunction n ≤ exponent := by
    dsimp [exponent]
    nlinarith [hmax]
  have hpow : exponent ≤ 2 ^ exponent :=
    nat_le_two_pow exponent
  have hpos : 0 < 2 ^ exponent := by
    positivity
  have hpowStep : 2 ^ exponent < 2 ^ (exponent + 1) := by
    rw [pow_succ]
    nlinarith [hpos]
  have hfinal : gardenFunction n < 2 ^ (exponent + 1) :=
    lt_of_le_of_lt (Nat.le_trans hmargin hpow) hpowStep
  have hexponent :
      exponent + 1 =
        prefixMaximum gardenFunction n + graphSetPrefixMaximum n + n + 3 := by
    simp [exponent, Nat.add_assoc]
  change gardenFunction n <
    2 ^ (prefixMaximum gardenFunction n + graphSetPrefixMaximum n + n + 3)
  rw [← hexponent]
  exact hfinal

/-- The graph/set Spark transform is monotone even when the input is not. -/
theorem koyoriSparkTransform_monotone (gardenFunction : Nat → Nat) :
    Monotone (koyoriSparkTransform gardenFunction) := by
  intro a b hab
  have hGarden : prefixMaximum gardenFunction a ≤ prefixMaximum gardenFunction b :=
    prefixMaximum_monotone gardenFunction hab
  have hGraph : graphSetPrefixMaximum a ≤ graphSetPrefixMaximum b :=
    prefixMaximum_monotone graphSetCount hab
  have hexponent :
      prefixMaximum gardenFunction a + graphSetPrefixMaximum a + a + 3 ≤
        prefixMaximum gardenFunction b + graphSetPrefixMaximum b + b + 3 := by
    change prefixMaximum gardenFunction a + prefixMaximum graphSetCount a + a + 3 ≤
      prefixMaximum gardenFunction b + prefixMaximum graphSetCount b + b + 3
    change prefixMaximum graphSetCount a ≤ prefixMaximum graphSetCount b at hGraph
    nlinarith [hGarden, hGraph, hab]
  unfold koyoriSparkTransform
  gcongr

/--
A monotone pointwise majorant iterates strictly above the function it
majorizes. The original function itself need not be monotone.
-/
theorem natIterate_strict_of_monotone_majorant
    {f g : Nat → Nat}
    (hg : Monotone g)
    (hfg : ∀ n, f n < g n) :
    ∀ (steps : Nat), 0 < steps →
      ∀ seed, natIterate f steps seed < natIterate g steps seed := by
  intro steps
  induction steps with
  | zero =>
      intro h
      simp at h
  | succ steps ih =>
      intro h seed
      cases steps with
      | zero =>
          simpa [natIterate] using hfg seed
      | succ steps =>
          have hprev :
              natIterate f (steps + 1) seed <
                natIterate g (steps + 1) seed :=
            ih (Nat.succ_pos _) seed
          change f (natIterate f (steps + 1) seed) <
            g (natIterate g (steps + 1) seed)
          exact lt_of_lt_of_le
            (hfg (natIterate f (steps + 1) seed))
            (hg hprev.le)

/-- The LNGN comparison expression under one fixed total function. -/
def gardenNumber (gardenFunction : Nat → Nat) : Nat :=
  natIterate gardenFunction 10 gardenSeed

/-- Ten finite Koyori Spark experiments, beginning at the LNGN seed. -/
noncomputable def koyoriSparkNumber (gardenFunction : Nat → Nat) : Nat :=
  natIterate (koyoriSparkTransform gardenFunction) 10 gardenSeed

/-- HKN is a finite exponent tower whose height is fixed by the Spark number. -/
noncomputable def hakuiKoyoriNumber (gardenFunction : Nat → Nat) : Nat :=
  towerAboveBenchmark (koyoriSparkNumber gardenFunction)

/--
Main theorem: for every total f : Nat → Nat, the graph/set HKN strictly
exceeds the corresponding f^10(10 up-arrow rank 10 applied to 10).
-/
theorem hakuiKoyoriNumber_gt_gardenNumber
    (gardenFunction : Nat → Nat) :
    gardenNumber gardenFunction < hakuiKoyoriNumber gardenFunction := by
  have h₁ :
      gardenNumber gardenFunction < koyoriSparkNumber gardenFunction := by
    unfold gardenNumber koyoriSparkNumber
    exact natIterate_strict_of_monotone_majorant
      (koyoriSparkTransform_monotone gardenFunction)
      (fun n => koyoriSparkTransform_gt gardenFunction n)
      10
      (by decide)
      gardenSeed
  have h₂ :
      koyoriSparkNumber gardenFunction <
        hakuiKoyoriNumber gardenFunction := by
    change koyoriSparkNumber gardenFunction <
      towerAboveBenchmark (koyoriSparkNumber gardenFunction)
    exact towerAboveBenchmark_gt (koyoriSparkNumber gardenFunction)
  exact lt_trans h₁ h₂

/-- The HKN expression denotes a natural number for every total f. -/
theorem hakuiKoyoriNumber_is_finite (gardenFunction : Nat → Nat) :
    ∃ N : Nat, N = hakuiKoyoriNumber gardenFunction :=
  ⟨hakuiKoyoriNumber gardenFunction, rfl⟩

end HakuiKoyori
