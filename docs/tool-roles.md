# Research tool and repository roles

This table distinguishes implemented use, reference use, and planned independent review. A listed repository is not claimed to have executed code or produced a proof unless that is explicitly recorded.

| Tool/repository | Role in this project | Status |
|---|---|---|
| Lean 4 + mathlib4 | Main formal definition of finite simple graphs, subgraphs, cardinalities, iteration, and arithmetic comparison | Used in source; CI pending |
| graphillion/graphillion | Reference for representing and enumerating families of graph substructures | Reference only |
| graph-theory-AI/graph-conjectures | Check whether the construction accidentally relies on an unproved graph conjecture | Review target; no conjecture is required by the definition |
| graph-theory-AI/graph-theory-rocq | Independent Rocq representation of the hypercube and graph-subgraph family | Future cross-check |
| rocq-community/graph-theory | Rocq graph definitions and finite graph API comparison | Future cross-check |
| rocq-community/fourcolor | Example of a substantial kernel-checked graph-theory development and proof discipline | Reference only; four-colour theorem is not needed |
| math-comp/math-comp | Alternative finite-set and finite-graph representation for a future Rocq/math-comp cross-check | Future cross-check |
| MizarSystem/MML | Independent statement-level comparison for finite sets, powersets, and graph basics | Reference only |
| metamath/metamath-exe and metamath/set.mm | Independent foundational/set-theoretic proof style and axiom-dependency comparison | Reference only |
| isabelle-prover/mirror-isabelle and mirror-afp-devel | Independent Isabelle/HOL formalization route for finite graph/set lemmas | Future cross-check |
| cvc5/cvc5 | Bounded finite checks and counterexample search for small n; not the main proof checker | Optional |
| lean-dojo/LeanDojo-v2 | Retrieve relevant Mathlib lemmas and suggest proof tactics | Optional; kernel decides |
| Singular/Singular, Macaulay2/M2 | Reserved only if algebraic subproblems arise | Not currently needed |
| gap-system/gap | Small finite combinatorial checks where group symmetry becomes relevant | Optional |
| sympy/sympy and sagemath/sage | Independent small-instance calculations and notation experiments | Optional; not proof |
| flintlib/flint | Exact integer arithmetic for small computable checks | Optional |
| MeniRosenfeld/TransfiniteOrdinalCalculator | Inspect ordinal/CNF notation when the LNGN semantic bridge is resumed | Reference only |
| hypcos/incremental-googology and koteitan/basmat-2.x | Compare googological notation conventions and fast-growing hierarchy terminology | Reference only |
| bbchallenge-proofs, jeff87654/busy-beaver, google-deepmind/cryptids | Proof-engineering references for computation semantics; no Busy Beaver value is used in HKN | Reference only |
| flagmatic | Exact extremal-graph calculations if a later version uses a genuine extremal bound | Not needed by current definition |

## Connected research tools

- Sider Scholar: academic discovery for graph/set combinatorics. Initial searches returned no paper from OpenAlex on the short query; a Google Scholar search returned graph/Ramsey references. No paper is used as a proof premise.
- Parallel Search: source verification for LNGN and official Hololive facts.
- Context7: current Lean/Mathlib API documentation.
- Wolfram: mathematical context was queried, but it returned no substantive result used in the proof.
- GitHub: repository inspection and source publication. GitHub Actions provides the free CI execution path when available.

The finite graph/set proof is intended to depend only on the Lean kernel and its declared Mathlib imports, not on the output of any AI agent, symbolic solver, or graph-enumeration program.
