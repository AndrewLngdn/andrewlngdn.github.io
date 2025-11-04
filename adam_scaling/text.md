# Visualizing Adam’s adaptive learning rates

If you've trained a machine learning model in the past, there's a good chance you've optimized with Adam. A big reason for Adam's success is that it determines individual learning rates for each model parameter, making large updates when confident, and small updates when uncertain.

Adam keeps two running statistics for each parameter: 

1. a moving average of past gradients, capturing gradient trend, and
2. a moving average of the squared gradients, capturing gradient intensity

The first changes slowly, filtering out noise. “Uncertain” gradients that bounce around zero will average out near zero, while consistent gradients remain either positive or negative. The second captures gradient intensity. Dividing the average by this intensity gives a value typically between 0 and 1. Adam uses this scaling factor to attenuate the global learning rate for each individual parameter.

Instead of starting bottom-up with the full set of equations, let’s analyze top-down looking at the full system behavior. 

Here’s the Adam parameter update rule:

$$
\theta_{t+1} = \theta_t - \eta \frac{\hat{m}_t}{\sqrt{\hat{v}_t} + \epsilon}
$$

$\hat{m}_t$  is the moving average of our gradients, and $\sqrt{\hat{v}_t}$ is the square root of our squared gradients. Taking the square root brings the denominator to the same scale as the numerator. 

We will be focusing on that ratio, $\hat{m}_t / (\sqrt{\hat{v}_t} + \epsilon)$, which we will call the learning-rate scale. It determines how much of the global learning rate $\eta$  is effectively applied to each parameter.

The complete update rule can be found in the Adam publication: https://arxiv.org/pdf/1412.6980. 

We can simulate different gradient patterns to see how they change the effective learning rate. In the below visualizations, our gradients are represented by a lollipop icon, the moving average $\hat{m}_t$ is shown in blue, and $\sqrt{\hat{v}_t}$ is shown in orange.

When the gradients consistently say, “raise this parameter for better performance”, Adam’s moving average builds confidence. The learning-rate scale remains close to one, and the parameter makes larger updates:

If the gradients are inconsistent around zero, the optimizer becomes more cautious. Imagine hearing, “lower this, wait, now raise it, ok now lower again, wait…”. In this case, we’d want to avoid big steps and instead make smaller adjustments. The learning-rate scale diminishes, which means smaller, fine-tuned update steps:

When gradient directions flip after being consistent, the scale briefly drops, then rebuilds as a new trend forms. This helps prevent overshooting and stabilizes learning.

Adam’s adaptive behavior is why it works so well on complex, high-dimensional surfaces: it learns how much to trust its own gradients.

If you want to see a visualization about something ML-related, contact me at andrewlngdn@gmail.com. See ya!