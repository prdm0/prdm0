library(magick)
library(magrittr)

newlogo <- image_scale(image_read("./R/criando_animacao/correspondencia_com_efeito.jpg"))
oldlogo <- image_scale(image_read("./R/criando_animacao/correspondencia.jpg"))
image_resize(c(oldlogo, newlogo), '1500x550!') %>%
  image_background('white') %>%
  image_morph() %>%
  image_animate(fps = 3, loop = 1L, optimize = TRUE, delay = 1/2)