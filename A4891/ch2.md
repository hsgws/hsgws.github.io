## 式 (2.9)

$$
\begin{eqnarray}
E[s_w^2] &=& \frac{1}{M-N} E\left[ \sum_{j=1}^N \sum_{i=1}^n (y_{ij}-\bar{y}_{.j})^2 \right] \tag{1} \\ 
&=& \frac{1}{M-N} \sum_{j=1}^N  E\left[\sum_{i=1}^n\left(r_{ij} - \bar{r}_{.j} \right)^2 \right] \qquad \bar{r}_{.j}=\frac{1}{n}\sum_{i-1}^n r_{ij}  \tag{2}\\
&=& \frac{1}{M-N} \sum_{j=1}^N (n-1) \sigma^2  \tag{3}\\
&=& \frac{N(n-1) \sigma^2}{Nn-N} \\
&=& \sigma^2
\end{eqnarray}
$$

$(1) \to (2)$  

$y_{ij}=\beta_{0j}+r_{ij}$，$\bar{y}_{.j}=\frac{1}{n}\sum_{i=1}^n y_{ij}$ より，
$$
\begin{eqnarray}
y_{ij}-\bar{y}_{.j} &=& (\beta_{0j}+r_{ij})-\frac{1}{n}\sum_{i=1}^n(\beta_{0j}+r_{ij}) \\
&=& (\beta_{0j}+r_{ij}) - \frac{1}{n} \left(n\beta_{0j}+\sum_{i=1}^nr_{ij} \right) \\
&=& r_{ij}-\bar{r}_{.j}
\end{eqnarray}
$$
$(2)\to(3)$

標本分散 $S^2 = \frac{1}{n}\sum_{i=1}^n(x_i-\bar{x})^2$ の期待値は $E[S^2] = \frac{n-1}{n}\sigma^2$となることより，
$$
\begin{eqnarray}
E\left[ \sum_{i=1}^n\left(r_{ij} - \bar{r}_{.j} \right)^2 \right] &=& n E\left[ \frac{1}{n} \sum_{i=1}^n\left(r_{ij} - \bar{r}_{.j} \right)^2 \right] \\
&=& n\cdot \frac{n-1}{n}\sigma^2 \\
&=& (n-1)\sigma^2
\end{eqnarray}
$$


## 式 (2.10) & (2.13)

$$
\begin{eqnarray}
E[s_b^2] &=& \frac{1}{N-1} E\left[\sum_{j=1}^N (\bar{y}_{.j}-\bar{y}_{..})^2\right] \\
&=& \frac{1}{N-1} E\left[\sum_{j=1}^N \left(\frac{1}{n}\sum_{i=1}^n(\beta_{0j}+r_{ij})-\frac{1}{Nn}\sum_{j=1}^N\sum_{i=1}^n(\beta_{0j}+r_{ij}) \right)^2 \right]\\
&=& \frac{1}{N-1} E\left[\sum_{j=1}^N \left((\beta_{0j}+\bar{r}_{.j}) -\frac{1}{N}\sum_{j=1}^N(\beta_{0j}+\bar{r}_{.j}) \right)^2 \right] \tag{1}\\
&=& \frac{1}{N-1} E\left[\sum_{j=1}^N \left( (\beta_{0j}-\gamma_{00})-\frac{1}{N}\sum_{j=1}^N(\beta_{0j}-\gamma_{00})\right)^2 + \sum_{j=1}^N \left( \bar{r}_{.j}-\frac{1}{N}\sum_{j=1}^N\bar{r}_{.j}\right)^2\right]  \tag{2}\\
&=& \frac{1}{N-1} \left( (N-1)\tau_{00} + \frac{N-1}{n}\sigma^2 \right) \tag{3}\\
&=& \tau_{00} +\frac{\sigma^2}{n}
\end{eqnarray}
$$

$(2)\to(3)$：$E$ 内の第1項

分散の定義により，
$$
E[(\beta_{0j}-\gamma_{00})^2] = \tau_{00}
$$
$E[(\beta_{0j}-\gamma_{00})(\beta_{0j'}-\gamma_{00})]=0 \ (j \neq j')$ より
$$
E\left[-2(\beta_{0j}-\gamma_{00})\frac{1}{N}\sum_{j=1}^N(\beta_{0j}-\gamma_{00})\right] = -\frac{2}{N}\tau_{00}
$$

$$
E\left[\frac{1}{N^2}\sum_{j=1}^N(\beta_{0j}-\gamma_{00})^2 \right] = \frac{1}{N}\tau_{00}
$$

以上から
$$
\sum_{j=1}^N\left(\tau_{00}-\frac{2}{N}\tau_{00} +\frac{1}{N}\tau_{00}\right) = \sum_{j=1}^N \frac{N-1}{N}\tau_{00} = (N-1)\tau_{00}
$$
$(2)\to(3)$：$E$ 内の第2項



