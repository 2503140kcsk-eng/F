# Definition of the Graph/Set Laboratory Hakui Koyori Number

## 1. Finite set universe

For n in the natural numbers, the label type is Fin n, and the reagent/vertex universe is its finite powerset:

\[
V_n=\mathcal P(\operatorname{Fin}(n)).
\]

Lean representation: ReagentSet n := Finset (Fin n).

## 2. Hypercube graph

Define a simple undirected graph Q_n with vertex set V_n:

\[
Q_n(A,B)\iff A\ne B\ \land\
|A\setminus B|+|B\setminus A|=1.
\]

An edge is a one-ingredient change between two subsets. This is the usual n-dimensional hypercube graph, with vertices represented as subsets rather than bit strings.

Lean representation: koyoriHypercube n.

## 3. Set of graph experiments

The experiment family is the type of all spanning subgraphs of Q_n:

\[
\mathcal E_n=\{H\in\operatorname{SimpleGraph}(V_n):H\le Q_n\}.
\]

Lean representation: KoyoriSubgraphSpace n.

Since Fin n is finite, its finite-set type is finite. The simple-graph type on a finite vertex type is finite, and a subtype of a finite type is finite. Thus the family has a natural-number cardinality:

\[
C(n)=|\mathcal E_n|\in\mathbb N.
\]

Lean representation: graphSetCount n := Fintype.card (KoyoriSubgraphSpace n).

This is a complete definition. It does not ask Lean to solve a graph conjecture or search an unbounded family. Intuitively, each spanning subgraph is obtained by selecting a subset of the edge set of Q_n. The formal definition uses the subtype cardinality directly.

## 4. Monotone finite envelopes

For any total f from natural numbers to natural numbers, let

\[
M_f(n)=\max_{0\le i\le n}f(i),\qquad
C^*(n)=\max_{0\le k\le n}C(k).
\]

Both are finite prefix maxima and hence monotone.

## 5. Koyori Spark transform

\[
S_f(n)=2^{M_f(n)+C^*(n)+n+3}.
\]

It is monotone because each exponent component is monotone. It strictly dominates f pointwise:

\[
f(n)\le M_f(n)\le M_f(n)+C^*(n)+n+2
<2^{M_f(n)+C^*(n)+n+3}.
\]

The last strict inequality follows from m <= 2^m for every natural number m, plus one additional factor of 2.

## 6. HKN

Let

\[
b=10\uparrow^{10}10,\qquad A_f=S_f^{10}(b).
\]

Define the tower sequence

\[
T_A(0)=A+2,\qquad T_A(k+1)=2^{T_A(k)}.
\]

Then

\[
\boxed{\operatorname{HKN}(f)=T_{A_f}(A_f+1).}
\]

All iterations are over natural-number indices and all function applications return natural numbers. Hence this layer is total and finite for every total input function f.

## 7. Main theorem

A monotone pointwise majorant iterates above the function it majorizes. Since S_f is monotone and f(n)<S_f(n) for all n,

\[
f^{10}(b)<S_f^{10}(b)=A_f.
\]

The tower starts at A_f+2 and never decreases, so

\[
A_f<T_{A_f}(A_f+1)=\operatorname{HKN}(f).
\]

Therefore

\[
\boxed{f^{10}(10\uparrow^{10}10)<\operatorname{HKN}(f).}
\]

The theorem is unconditional for each total f. Its application to the canonical LNGN requires the separate source-semantics bridge described in semantics-audit.md.
