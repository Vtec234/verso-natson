import Verso
import VersoManual
import VersoBlueprint
import Carleson.Classical.ClassicalCarleson
import CarlesonBlueprint.TeXPrelude

open Verso.Genre
open Verso.Genre.Manual
open Informal

#doc (Manual) "Formalization of Carleson's theorem" =>

This paper is the blueprint underlying the Lean formalization of the proof of
Carleson's classical result asserting almost everywhere convergence of Fourier
series of continuous functions. We break up the proof into two steps, a
reduction of the classical result to a new theorem that appears in the sibling
communication and a proof of this new theorem, which is also detailed as
blueprint in this paper. An early version of this blueprint was used to
initiate the Lean formalization. During the formalization, many contributors
elaborated the blueprint with minor corrections, modifications and extensions.
The final version is presented here as a guide through the accompanying Lean
code.

```tex "main.abstract"
\begin{abstract}
This paper is the blueprint underlying the Lean formalization of the proof of Carleson's classical result \cite{carleson} asserting almost everywhere convergence of Fourier series of continuous functions. We break up the proof into two steps, a reduction of the classical result to a new theorem that appears in the sibling communication \cite{becker2024carlesonoperatorsdoublingmetric} and a proof of this new theorem, which is also detailed as blueprint in this paper. An early version of this blueprint was used to initiate the Lean formalization. During the formalization, many contributors elaborated the blueprint with minor corrections, modifications and extensions.
The final version is presented here as a guide through the accompanying Lean code.
\end{abstract}
```

# Introduction

Trigonometric series represent functions as possibly infinite linear
combinations of pure frequencies. They gained particular prominence through the
work of J. Fourier, who used them in his analytical theory of heat, thereby
establishing them as a tool for solving partial differential equations. Fourier
also made the groundbreaking claim that a wide range of functions could be
represented using trigonometric series. This sparked the interest of many
mathematicians, including Dirichlet, who gave some rigorous conditions for
convergence of Fourier series, as trigonometric series are now called.
Dirichlet also opened a branch of analytic number theory partially inspired by
the ideas of Fourier. Nowadays, Fourier analysis plays an important role in
many areas of mathematics.

```tex "main.introduction.1"
Trigonometric series represent functions as possibly infinite linear combinations of pure frequencies.
They gained particular prominence through the work of J. Fourier, who used them in his analytical theory of heat \cite{Fourier}, see also \cite{MR3470070}, thereby establishing them as a tool for solving partial differential equations.
Fourier also made the groundbreaking claim that a wide range of functions could be represented using trigonometric series. This sparked the interest of many mathematicians,
including Dirichlet, who gave some rigorous conditions for convergence of Fourier series, as trigonometric series are now called. Dirichlet also opened a branch of analytic number theory partially inspired by the ideas of
Fourier.
Nowadays, Fourier analysis plays an important role in many areas of mathematics.
```

With Euler's formula to represent pure frequencies in mind, a trigonometric
polynomial can be expressed as
$$`S_N(x):= \sum_{n=-N}^N c_n e^{inx}.`$$
The Fourier series is then defined as the limit $`f` of such a sequence $`S_N`
as $`N` tends to $`\infty`. Fourier's vision to represent rather general
functions raises two fundamental questions. The first question is to identify
the appropriate choice of coefficients $`c_n` to use to represent a given
$`f`. The second question addresses the convergence of $`S_N` to $`f`.

```tex "main.introduction.2"
With Euler's formula to represent pure frequencies in mind, a trigonometric polynomial can be expressed as
\begin{equation}\label{eq:trig-series}
    S_N(x):= \sum_{n=-N}^N c_n e^{inx} \ .
\end{equation}
The Fourier series is then defined as the limit $f$ of such a sequence $S_N$
as $N$ tends to $\infty$. Fourier's vision to represent rather general
functions raises two fundamental questions. The first question is to identify
the appropriate choice of coefficients $c_n$ to use to represent a given $f$.
The second question addresses the convergence of $S_N$ to $f$.
```

The first question has a fairly canonical and standard answer, provided by the
Fourier integral formula:
$$`c_n := \widehat{f}_n := \frac 1{2\pi}\int_0^{2\pi} f(x)e^{-inx}\, dx.`$$
Here the precise interpretation of the integral depends on the chosen theory
of integration. For a continuous function $`f`, Riemann's notion of the
integral suffices. If $`f` is integrable in the Lebesgue sense,
$`f \in L^1(0,2\pi)`, the Lebesgue integral is appropriate. More generally, if
$`f` is a distribution in the sense of Schwartz, supported in $`[0,2\pi]`, the
integral can be understood as an evaluation against the periodic test function
$`e^{-inx}`. In each case, the more general definition reduces to the simpler
one within the respective more restrictive domain. Hence, the Fourier
coefficients given above serve as a universal choice. This choice is unique in
several respects, in particular if one is to exactly reproduce a trigonometric
polynomial $`f`.

```tex "main.introduction.3"
The first question has a fairly canonical and standard answer, provided by the Fourier integral formula:
\begin{equation}\label{eq:fourier-coefficients}
    c_n:=\widehat{f}_n:=\frac 1{2\pi}\int_0^{2\pi}f(x) e^{- i nx}\, dx,
\end{equation}
 where the precise interpretation of the integral depends on the chosen theory of integration. For a continuous function $f$,
Riemann's notion of the integral suffices. If $f$ is integrable in the Lebesgue sense,
$f\in L^1(0,2\pi)$, the Lebesgue integral is appropriate. More generally, if
$f$ is a distribution in the sense of Schwartz, supported in $[0,2\pi]$
the integral can be understood as an evaluation against the periodic test function
$e^{-i nx}$. In each case, the more general definition reduces to the simpler one within the respective more restrictive domain.
Hence, the Fourier coefficients given by \eqref{eq:fourier-coefficients} serve as a universal choice.
This choice is unique in several respects, in particular if one is to exactly reproduce
a trigonometric polynomial $f$ in the form
\eqref{eq:trig-series}.
```

The second question of convergence bifurcates into the question of pointwise
convergence of the series with coefficients given above for a given $`x` on
the one hand and convergence of the functions $`S_N` to the function $`f` in a
suitable function space with corresponding topology on the other hand. There
are at least as many function spaces for the question of convergence as there
are different definitions of the integral elaborated earlier. There are some
very canonical answers to the convergence question in function spaces, albeit
not known at the time of Fourier and Dirichlet. One example is convergence in
the Hilbert space sense for $`f` in $`L^2(0,2\pi)`, as discovered in the first
decade of the twentieth century as a consequence of the rapid development of
Lebesgue integration theory. Another canonical example is convergence in the
sense of distributions for general distributional $`f`, as discovered a few
decades after Lebesgue integration. For some other natural spaces, such as
$`L^1(0,2\pi)`, there is no guarantee of convergence in the norm of that space
even if $`f` is in the space.

```tex "main.introduction.4"
The second question of convergence bifurcates into the question of pointwise
convergence of the series \eqref{eq:trig-series} (with coefficients given by
\eqref{eq:fourier-coefficients}) for a given $x$ on the one hand and
convergence of the functions $S_N$ to the function $f$ in a suitable function
space with corresponding topology on the other hand. There are at least as
many function spaces for the question of convergence as there are different
definitions of the integral elaborated earlier. There are some very canonical
answers to the convergence question in function spaces, albeit not known at
the time of Fourier and Dirichlet. One example is convergence in the Hilbert
space sense for $f$ in $L^2(0,2\pi)$, as discovered in the first decade of
the twentieth century as a consequence of the rapid development of Lebesgue
integration theory. Another canonical example is convergence in the sense of
distributions for general distributional $f$, as discovered a few decades
after Lebesgue integration. For some other natural spaces, such as
$L^1(0,2\pi)$, there is no guarantee of convergence in the norm of that space
even if $f$ is in the space.
```

In contrast to these examples of function spaces with a very natural theory of
convergence of Fourier series in the topology of the function space, there are
no similarly elegant solutions to the characterization of pointwise
convergence. In particular, the space of functions $`f` such that the sequence
$`S_N(x)` converges for every $`x` does not have a good characterization in
terms of $`f` itself. Similarly, the space of all functions $`f` such that the
sequence of coefficients $`\widehat{f}_n` is absolutely summable has also no
good characterization.

```tex "main.introduction.5"
In contrast to these examples of function spaces with a very natural theory
of convergence of Fourier series in the topology of the function space, there
are no similarly elegant solutions to the characterization of pointwise
convergence. In particular, the space of functions $f$ such that the sequence
$S_N(x)$ converges for every $x$ does not have a good characterization in
terms of $f$ itself. Similarly, the space of all functions $f$ such that the
sequence of coefficients $\widehat{f}_n$ is absolutely summable has also no
good characterization.
```

When the Fourier integral is defined in the Lebesgue sense and
$`f \in L^1(0,2\pi)`, then the function $`f` itself is meaningful not
everywhere but only pointwise almost everywhere in the Lebesgue sense. The
question of pointwise convergence to $`f` for all $`x` then becomes
meaningless, and instead one asks for almost everywhere convergence. Such
convergence was conjectured by N. Luzin for the space $`L^2(0,2\pi)`.
Kolmogorov's example of an $`L^1` function whose Fourier series diverges at
almost every point seemed to provide some evidence against Luzin's conjecture.
Indeed, in the 1960s, L. Carleson tried to construct a counterexample to
Luzin's conjecture. In his own recollection, his efforts led him to better and
better understand how such a potential counterexample should look like. In the
end, the counterexample had to satisfy so many properties that the properties
started to contradict each other, and Carleson realized that a counterexample
could not exist. Thus, he had proved Luzin's conjecture. In particular, he had
proven the more elementary statement

```tex "main.introduction.6"
When the Fourier integral is defined in the Lebesgue sense and
$f\in L^1(0,2\pi)$, then the function
$f$ itself is meaningful not everywhere but only pointwise almost everywhere
in the Lebesgue sense. The question of pointwise convergence to $f$ for all $x$ then becomes
meaningless, and instead one asks for almost everywhere convergence.
Such convergence
was conjectured by N. Luzin \cite{Luzin13}
for the space
$L^2(0,2\pi)$, see also the collected works \cite{Luzin53}. Kolmogorov's example \cite{Kolmogorov} of an $L^1$ function whose Fourier series diverges at almost every point seemed to provide some evidence against Luzin's conjecture.
Indeed, in the 1960s, L. Carleson tried to construct a counterexample to Luzin's conjecture.
In his own recollection, his efforts led him to better and better understand how such a potential counterexample should look like.
In the end, the counterexample had to satisfy so many properties that the properties started to contradict each other,
and Carleson realized that a counterexample could not exist.
Thus, he had proved Luzin's conjecture \cite{carleson}.
In particular, he had proven the more elementary statement
```

:::theorem "classical-carleson" (lean := "classical_carleson")
{uses "exceptional-set-carleson"}[]
Let $`f` be a $`2\pi`-periodic complex-valued continuous function on
$`\mathbb{R}`. Then for almost all $`x \in \mathbb{R}` we have
$$`\lim_{N\to\infty} S_N f(x) = f(x),`$$
where $`S_N f` is the $`N`-th partial Fourier sum defined above with Fourier
coefficients defined above.
:::

```tex "classical-carleson" (slot := statement)
\begin{theorem}[classical Carleson]
    \label{classical-carleson}
    \leanok
    \lean{classical_carleson}
    \uses{exceptional-set-carleson}
    Let $f$ be a $2\pi$-periodic complex-valued continuous function on $\mathbb{R}$.
    Then for almost all $x \in \mathbb{R}$ we have
    \begin{equation}\label{eq:fourier-limit}
      \lim_{N\to\infty}S_N f(x) = f(x),
    \end{equation}
    where $S_N f$ is the $N$-th partial Fourier sum of $f$ defined in \eqref{eq:trig-series}
    with coefficients \eqref{eq:fourier-coefficients}.
\end{theorem}
```

Here, almost every $`x` means in the Lebesgue sense, that is, for every
$`\epsilon > 0` the set of $`x` where convergence fails can be covered by a
sequence of intervals such that the sum of the lengths of these intervals is
less than $`\epsilon`. While Carleson had proven the more general Luzin
conjecture for functions in $`L^2[0,2\pi]`, even the more elementary statement
for continuous functions was not known before Carleson's work. Moreover, until
now, the elementary statement has not seen any substantially easier proof than
those generalizing to $`L^2`, partially because there is no readily usable
criterion on the level of Fourier coefficients to distinguish between
continuous functions and $`L^2` functions.

```tex "main.introduction.7"
Here, almost every $x$ means in the Lebesgue sense, i.e., for every $\epsilon>0$ the set of $x$ where convergence fails can be covered by a sequence of intervals
such that the sum of the lengths of these
intervals is less than $\epsilon$. While Carleson had proven the more general Luzin conjecture for functions in $L^2[0,2\pi]$, even the more elementary statement for continuous functions was not known before Carleson's work.
Moreover, until now, the elementary statement has not seen any substantially easier proof than those generalizing to $L^2$,
partially because there is no readily usable criterion on the level of
Fourier coefficients to distinguish between continuous functions and $L^2$ functions.
```
