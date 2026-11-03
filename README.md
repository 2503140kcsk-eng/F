# Hakui Koyori Number — Graph/Set Laboratory Edition（博衣こより数）

**A Lean 4 formalization of a finite graph-and-set growth construction inspired by Hakui Koyori.**

- Project: **Hakui Koyori Number (HKN)**
- Edition: **Graph/Set Laboratory**
- Repository: https://github.com/2503140kcsk-eng/F
- Initial source submission: 2026-11-03
- Verification: pending GitHub Actions on the submitted commit.
- This is an independent fan-inspired mathematics project. It is not affiliated with or endorsed by Cover Corp. or Hololive.

## 1. Research target

The community-reported Large Number Garden Number expression is

\[
\operatorname{LNGN}(f)=f^{10}(b),\qquad b=10\uparrow^{10}10,
\]

where \(f^{10}\) means tenfold composition. The source-level meaning of \(f\) is a separate model-theoretic issue; see the LNGN semantic audit in docs.

This repository develops a graph/set-theoretic amplifier. It proves a strict inequality for every total function \(f:\mathbb N\to\mathbb N\), and therefore applies to the LNGN interpretation once that exact source function is supplied.

## 2. The laboratory graph and its set of experiments

For each \(n\), let the reagent universe be the finite power set

\[
V_n=\mathcal P([n]).
\]

In Lean each vertex is represented by its characteristic function Fin n → Bool, with the corresponding finite subset recovered by reagentSubset. This is the standard powerset/function correspondence.

Define the \(n\)-dimensional hypercube graph \(Q_n\) on \(V_n\). Two vertices \(A,B\) are adjacent exactly when

\[
A\ne B,\qquad |A\setminus B|+|B\setminus A|=1.
\]

Thus an edge represents changing exactly one experimental ingredient.

Let

\[
\mathcal E_n=\{H:H\text{ is a spanning subgraph of }Q_n\},
\qquad C(n)=|\mathcal E_n|.
\]

C(n) is not a free parameter: Lean defines it as the Fintype.card of the subtype of all simple graphs below Q_n. Since the vertex universe is finite, the graph type and this subgraph family are finite. The powerset/set-system layer is part of the actual definition, not merely a metaphor.

For a total function \(f:\mathbb N\to\mathbb N\), define the finite prefix maxima

\[
M_f(n)=\max_{0\le i\le n}f(i),\qquad
C^*(n)=\max_{0\le k\le n}C(k).
\]

The Koyori Spark transform is

\[
S_f(n)=2^{\,M_f(n)+C^*(n)+n+3}.
\]

Put

\[
b=10\uparrow^{10}10,\qquad
A_f=S_f^{10}(b).
\]

Finally define a finite exponential tower by

\[
T_A(0)=A+2,\qquad T_A(j+1)=2^{T_A(j)}
\]

and set

\[
\boxed{\operatorname{HKN}(f)=T_{A_f}(A_f+1).}
\]

All iteration counts are natural numbers determined by the preceding definitions. No open-ended search, unresolved combinatorial conjecture, or unspecified numerical parameter occurs in this arithmetic layer.

## 3. Main Lean theorem

The module HakuiKoyori/GraphSet.lean defines the graph, the finite graph-subsystem count, the transform, the iterates, and the final tower. The target theorem is

\[
\boxed{
f^{10}(b)<S_f^{10}(b)<\operatorname{HKN}(f)
}
\]

for every total function \(f:\mathbb N\to\mathbb N\).

No monotonicity assumption on f is used. The running maxima make S_f monotone, while the M_f(n) term ensures S_f(n)>f(n). The graph/set count is incorporated additively into the exponent and is itself finite.

The final tower is finite by structural recursion on the natural-number height and exceeds its input benchmark.

## 4. Important status distinction

The arithmetic theorem is parametric in f. It is not yet the closed, source-instantiated theorem for the canonical LNGN, because the original LNGN construction uses a strong theory with an ordinal-indexed model hierarchy and a satisfaction relation. Existence and coherence of the intended models, exact coding conventions, and the resulting total function still require a separate formal semantic bridge.

Accordingly, this repository does not claim that the canonical numerical value of LNGN has already been formalized here. The theorem says: under any one fixed interpretation that supplies the same total function f to both sides, HKN strictly exceeds the corresponding f^10(b).

There is no absolute largest definable natural number: if N is definable, then N+1 is definable and larger. Any “largest” claim must specify a language, theory, or comparison convention.

## 5. Verification

- Lean toolchain: pinned in lean-toolchain.
- Mathlib revision: pinned in lakefile.lean.
- CI: .github/workflows/ci.yml.
- The CI build and axiom audit must pass on the current commit before the source is described as verified.
- No sorry, admit, or project-defined axiom is intended.

See:
- Exact definition: docs/definition.md
- LNGN semantic audit: docs/semantics-audit.md
- Verification status: docs/verification-status.md
- Research-tool roles: docs/tool-roles.md

## 6. Research-tool roles

The main proof checker is Lean's kernel. Mathlib supplies the finite simple-graph structures. Graphillion and the graph-theory repositories are references for finite graph-family representations, not proof certificates. Rocq/math-comp, Mizar, Metamath, and Isabelle are reserved for independent re-formalization of the finite graph/set lemmas. Sider Scholar and Parallel Search support literature/source discovery; Context7 checks current Lean/Mathlib APIs; Wolfram can sanity-check small finite examples. None of these tools replaces the Lean kernel or proves the LNGN semantic assumptions.

The project uses free/open-source proof tools and GitHub Actions. External computational tools are optional and are not part of the trusted proof base.
