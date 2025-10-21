# 🌡️ Control de Temperatura con ESP32 — Módulo MIACON

### Proyecto: Módulo de Control de Temperatura de Bajo Costo para Aprendizaje Autónomo  
**Autor:** [Tu nombre o grupo de trabajo]  
**Institución:** [Nombre de la universidad o programa]  
**Versión:** 1.0  
**Licencia:** MIT  
**Fecha:** Octubre 2025  

---

## 📘 Descripción del Proyecto

Este repositorio contiene el código, diagramas y documentación del **Control de Temperatura** implementado con un **ESP32**, un **sensor DHT11** y una **resistencia calefactora** controlada mediante un **transistor NPN 2N2222A**.  
Forma parte del **Módulo Interactivo de Bajo Costo para el Aprendizaje Autónomo de Sistemas de Control (MIACON)**, orientado a la enseñanza de controladores **P, PI y PID** mediante **Simulink** y hardware real.

El sistema permite medir la temperatura ambiente, aplicar potencia proporcional a una resistencia calefactora y observar en tiempo real la respuesta térmica y el desempeño de distintos controladores.

---

## 🧩 Objetivos

- Implementar una **planta térmica de primer orden** de bajo costo y bajo consumo.
- Medir temperatura con un sensor digital (DHT11).
- Controlar la temperatura mediante modulación PWM del transistor 2N2222A.
- Permitir la interacción desde **Simulink o Python** para ajustar parámetros y observar la respuesta.
- Introducir conceptos de modelado, identificación y sintonía de controladores PI/PID.

---

## ⚙️ Componentes Utilizados

| Componente | Cantidad | Descripción |
|-------------|-----------|-------------|
| **ESP32 DevKit v1** | 1 | Microcontrolador principal |
| **Sensor DHT11** | 1 | Sensor digital de temperatura y humedad |
| **Transistor 2N2222A (NPN)** | 1 | Etapa de potencia para calefactor |
| **Resistencia calefactora 10–22 Ω / 1 W (5 V)** | 1 | Actuador térmico |
| **Resistencia 1 kΩ** | 1 | Limitadora de corriente base del transistor |
| **Diodo 1N4007** | 1 | Protección de inversión o transitorio |
| **Capacitor 470–1000 µF / 10 V** | 1 | Filtrado del bus de 5 V |
| **Protoboard y cables Dupont** | — | Conexión y pruebas |
| **Cable USB (5 V)** | 1 | Alimentación y comunicación con PC |

---


## 🧠 Principio de Funcionamiento

1. El **ESP32** mide la temperatura actual mediante el **DHT11**.  
2. Calcula el **error térmico** (temperatura deseada – medida).  
3. Genera una señal **PWM proporcional** (o control PI/PID) aplicada al **2N2222A**, que regula la potencia sobre la resistencia calefactora.  
4. El sistema térmico responde lentamente (planta de primer orden).  
5. Simulink o un monitor serial permiten visualizar la respuesta temporal.

---

## 🧪 Configuración del Software

### 🔸 Requisitos
- [Arduino IDE](https://www.arduino.cc/en/software) o PlatformIO
- Librería `DHT.h` (Adafruit)
- Librería `Adafruit Unified Sensor`
- ESP32 core para Arduino (instalable desde el gestor de placas)

### 🔸 Instalación
1. Clona este repositorio:
   ```bash
   git clone https://github.com/tuusuario/miacon-temp-control.git
   cd miacon-temp-control

