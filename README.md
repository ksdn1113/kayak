# Kayak mania!
(project name not defined yet)


Implementado en Godot 4.3

W.I.P.

#11/09/2024

La idea principal es realizar un juego que conste de una carrera de kayaks/canoas, en las que cada jugador con dos botones pueda elegir para qué lado frenar y ver cómo tomar la delantera.

En el prototipo actual, las teclas pueden ser asignadas dentro del inspector al seleccionar alguna instancia de la escena "kayak" que se encuentre en la escena principal.

Debido a que los kayaks se encuentran en una pendiente por la que caen, cada botón emula clavar el remo a un costado de la pendiente. Debido al uso de RigidBodys3D, a cada objeto kayak se le puede asignar un peso (pendiente: formas de distribuir peso dentro de un objeto), causando que caigan por la pendiente con mayor o menor velocidad. Cuando el botón que corresponde a ese lado del remo es presionado, se le aplica una fuera contraria al cuerpo del kayak, para que comience a frenar y en consecuencia también comenzar a virar. Por la lógica del clavar un remo, hay una sutil demora desde el momento en que comienza a frenar/virar el kayak y el instante en que se presiona el botón. Tampoco puede clavarse muy rápido el remo al otro costado, debido al tiempo que conlleva el remo pasar de un lado al otro (emulado y limitado mediante el uso de animaciones). 

TODO LIST:
* Implementar reset button
* Implementar puntaje en cada esquina
* Calibrar valores (Game Design/Testing)
* Implementar modelos, materiales y/o skyboxes
* Implementar triggers sonoros y wwise
* Crear escenas de menú y otras yerbas (configuraciones? selecciòn de niveles? personajes?)
* ???????
* Profit!
