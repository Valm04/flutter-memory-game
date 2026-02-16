# 🧠 Memory Game – Flutter

Memory Game es un juego interactivo donde el jugador debe **memorizar y repetir secuencias de botones con animales**.  
Cada nivel aumenta la dificultad y el jugador recibe **retroalimentación inmediata con sonidos, animaciones y diálogos emergentes**.

---

## 🎮 Screenshots / GIFs

### 1. Pantalla de inicio
![HomeScreen](assets/images/home.png)
*Botón “Play” con diseño animado, fondo colorido y acceso al juego.*

### 2. Pantalla de juego
![GameScreen](assets/images/secuence.jpeg)
![GameScreen](assets/images/hori.jpeg)
*Secuencias de animales, barra de tiempo pastel y animaciones al presionar cada botón.*

### 4. Pop-up de intento fallido
![LoseDialog](assets/images/loser.jpeg)
*Diálogo emergente que aparece cuando el jugador falla la secuencia.*


---

## ⚡ Características principales

- Secuencias de animales aleatorias y progresivas por nivel  
- Retroalimentación inmediata con sonidos 
- Fondos degradados y diseño responsive  
- Arquitectura modular para escalar fácilmente nuevos niveles, animales o efectos  

---

## 🛠️ Tecnologías y Widgets usados

- **Flutter / Dart** – desarrollo cross-platform  
- **Widgets clave**: `Scaffold`, `Column`, `Row`, `ClipRRect`, `LinearProgressIndicator`, `ElevatedButton`, `Dialog`  
- **Controladores**: `GameController` para lógica de secuencias y niveles  
- **Servicios**: `SoundService` para reproducir sonidos de botones  
- **Assets**: imágenes de animales, fondos y sonidos  
- **Responsive**: `OrientationBuilder` para soportar portrait y landscape  

---

