# Visualizing Adam’s adaptive learning rates

If you’ve trained a machine learning model in the past, there’s a good chance you’ve optimized with Adam. A big reason for Adam’s success is that it determines individual learning rates for each model parameter,  making large updates when confident, and small updates when uncertain.

(insert picture of frankie running the wrong way while playing fetch)

Adam calculates the adaptive learning rates by tracking two running averages: one for the mean of the past gradients, which describes directional information, and the other for something akin to variance, giving noise information. 

The ratio of the two gives an approximate signal-to-noise ratio. Parameters with high signal-to-noise get near-full learning-rate update steps, while those with low signal-to-noise get smaller ones.

Here’s the Adam parameter update rule:

$$
\theta_{t+1} = \theta_t - \eta \frac{\hat{m}_t}{\sqrt{\hat{v}_t} + \epsilon}
$$

A full explanation of the update rule can be found in the Adam publication: [https://arxiv.org/pdf/1412.6980](https://arxiv.org/pdf/1412.6980). 

We’re interested in the ratio on the right side of the equation, $\hat{m}_t / (\sqrt{\hat{v}_t} + \epsilon)$, which we will call the scaling ratio. It determines how much of the learning rate $\eta$ is effectively applied to each parameter.

Instead of looking at this bottom-up starting with the equations, let’s analyze top-down looking at the system behavior. 

We can simulate different gradient patterns to see how they change the effective step size via the scaling ratio. In the below visualizations, our gradients are represented by a lollipop icon, the moving average $\hat{m}_t$ is in blue, and the square root of the variance is in orange. 

The moving average $\hat{m}_t$ is shown in blue, and the root-mean-square of the gradients $\sqrt{\hat{v}_t}$ is shown in orange.

When the gradients consistently point the same way, the optimizer gains confidence. The gradient might say, “raise this parameter for better performance”. As “raise this parameter” information propagates into the moving average, Adam gains confidence about adjusting the parameter in that direction. The scaling ratio remains close to one, and the parameter gets larger step sizes:

If the gradients are inconsistent around zero, the optimizer becomes more cautious. Imagine hearing, “lower this, wait, now raise it, ok now lower again, wait…”. In this case, we’d want to avoid big steps and instead make smaller fine-tuned adjustments. The scaling ratio diminishes, which means smaller step sizes for the parameters:

Finally, we can see that longer gradient trends see a larger scaling ratio, but only after some amount of consistency.  Consistent gradients in one direction for an extended period of time grows the scaling ratio. As those gradients flip over the x-axis, confidence drops, and the effective step size shrinks, before recovering again after some consistency in the new direction: 

This LR scaling also gives us some per-parameter step size annealing as parameters approach local minima. Parameters close to a minimum experience noisier gradients, since moving in either direction increases loss and produces opposing gradients. This noise shrinks the scaling ratio, keeping parameters near their current locations.

If you want to see a visualization about something ML-related, contact me at andrewlngdn@gmail.com. See ya!