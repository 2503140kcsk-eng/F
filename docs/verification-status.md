# Verification status

## Initial submission

The source files define the finite hypercube, its spanning-subgraph family, the finite graph/set cardinality, the Koyori Spark transform, the LNGN seed, and the final finite tower.

The target kernel theorem is:

HakuiKoyori.hakuiKoyoriNumber_gt_gardenNumber

The build and axiom audit are pending until GitHub Actions completes on the exact commit containing these files. Do not treat the theorem as verified before a successful run.

## Required acceptance checks

- lake build --wfail succeeds with no warnings.
- Axiom audit for namespace HakuiKoyori passes with only the standard foundational axioms admitted by the configured audit.
- No sorry, admit, or user-defined axiom appears in the proof source.
- CI run URL and exact commit SHA are recorded here after success.
- Any edit to lean-toolchain, lakefile.lean, Number.lean, or GraphSet.lean requires a new build.

## Scope caveat

Even a successful arithmetic build proves the theorem for every total f : Nat → Nat. It does not itself prove the model-existence and semantic-identity obligations of the original LNGN definition. Those remain a separate formalization milestone.
