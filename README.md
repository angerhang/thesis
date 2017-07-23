# report change log

------ 21. 7. 2017 ------ edited by Tianlin
1. creat a copycat of Hang's thesis in a technical report format.


2.  add an account of current deep learning approach for RNN: why these vanishing/exploding gradients are alleviated in this approach.

3. change the figure 1 to make it consistent with text. Note that for the same reason I also edit the text a bit:  one should always use y^target in place of y^teach, consistenting with [1] listed below.

4. In the training step (page 3), correct the main square error as root mean square error.

5. To avoid unclear math formulation for Echo State Property (ESP), I remove the math formulation of ESP as a whole. Only interpretation in plain english is given. Indeed, I guess it is no need to abuse the notations to define what Echo State Property rigoriously means in math in this application-driven ESN paper. 

6. In "Size of the reservoir" bullet point, remove the "memory capacity" discussion. Only the "practical guide" is provided (choose the size as big as you can afford, but no bigger than 1+ N_u +N_x), consistent with [1]

7. Change the title "Post-processing" to "Model Optimzation"

# TODO-list

1. It will be great if Hang could answer the question "was any of these metavariables relevant for your study?", the question asked by Prof. Jaeger in page 11 of the feadback.

2. It will be great if Hang could answer the question "did YOU compute the MLS values? I thought that they were imported from Godde's work?", the question asked by Prof. Jaeger in page 14 of the feedback.




[1]Mantas Lukosevicius. A practical guide to applying echo state networks. In Neural Networks: Tricks of the Trade, pages 659–686. Springer, 2012.