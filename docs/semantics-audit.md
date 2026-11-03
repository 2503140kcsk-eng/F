# LNGN source-semantics audit

## Published comparison expression

Community documentation reports

\[
\operatorname{LNGN}=f^{10}(10\uparrow^{10}10),
\]

with f defined through a coded first-order set-theoretic language, a formal theory T, an ordinal-indexed family U(alpha), a satisfaction relation, and a finite sum over definable natural numbers.

References to inspect against the creator's original post:

- English community exposition: https://googology.miraheze.org/wiki/Large_Number_Garden_Number
- Japanese community exposition: https://googology.fandom.com/ja/wiki/巨大数庭園数
- Creator-source entry point referenced by the community page: https://googology.fandom.com/ja/wiki/ユーザーブログ:P進大好きbot/高階集合論を超えた1階述語論理

These pages are research sources, not a Lean proof that all semantic assumptions are consistent or that the function denotes one model-independent standard natural number.

## Semantic obligations

A complete instantiation still requires:

1. Freeze the creator's exact source text and version.
2. Fix the syntax of the base language, internal language, variables, symbols, terms, formulas, and finite strings.
3. Formalize the Gödel/meta-code maps and prove their required injectivity/decoding properties.
4. Formalize capture-avoiding substitution.
5. Formalize the natural-number-to-epsilon-zero CNF notation map with exact source conventions.
6. State the theory T, its U1, U2, U3 axioms, structures, and satisfaction predicate.
7. Separate consistency, universe, and model-existence assumptions from the arithmetic theorem.
8. Define the intended f as a total Nat to Nat function under the stated semantics.
9. Prove that the Lean f is exactly the source-defined function, rather than a similar substitute.

The source description invokes an ordinal-indexed hierarchy of models/universes and discusses a Grothendieck-universe assumption. The current project does not claim to construct that hierarchy unconditionally.

## Comparison convention

The HKN theorem compares both expressions under one and the same function f:

\[
\operatorname{LNGN}(f)=f^{10}(b),\qquad
\operatorname{HKN}(f)=T_{S_f^{10}(b)}(S_f^{10}(b)+1).
\]

It proves an ordinary natural-number inequality within that shared interpretation. It does not silently compare objects defined in unrelated theories or interpretations.

Until the source f is instantiated and the bridge is checked, the project status is:

- Graph/set construction: defined in Lean source.
- Finite-cardinality layer: defined using Fintype.card.
- Arithmetic inequality for arbitrary total f: submitted for CI verification.
- Canonical LNGN semantic instantiation: open.
- A single closed, source-instantiated HKN numeral: not yet certified.
