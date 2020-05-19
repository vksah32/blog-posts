# Math post

This is Math.

Here's formula for normal distribution in latex. Testing if it renders correctly.
$$
f(x) = \frac{e^{-(x - \mu)^{2}/(2\sigma^{2}) }} {\sigma\sqrt{2\pi}}
$$
More math stuff:


$$
\text{Theorem: For any } n \in \mathbb{N}, 
\sum_{i=1}^{n}i=\frac{n\left ( n+1 \right )}{2}
$$

proof:

Base case \(n=1\): If $n=1$, the left side is 1 and the right side is $\frac{1\left ( 2\right )}{2}=1$.
So, the theorem holds when $n=1$.
Inductive hypothesis: Suppose the theorem holds for all values of $n$ up to some $k$, $k \geq 1$.
Inductive step: Let $n=k+1$. Then our left side is
\begin{align}
$\sum_{i=1}^{k+1}i&=\left (k+1\right )+\sum_{i=1}^{k}i\\
&=\left (k+1\right )+\frac{k\left ( k+1 \right )}{2}$\text{, by our inductive hypothesis}\\
$&=\frac{2\left (k+1 \right )}{2}+\frac{k\left (k+1 \right )}{2}\\
&=\frac{2\left (k+1 \right )+k\left (k+1 \right )}{2}\\
&=\frac{\left (k+1 \right )\left (k+2\right )}{2}$
\end{align}
which is our right side. So, the theorem holds for $n=k+1$. 
By the principle of mathematical induction, the theorem holds for all $n \in \mathbb{N}$.


