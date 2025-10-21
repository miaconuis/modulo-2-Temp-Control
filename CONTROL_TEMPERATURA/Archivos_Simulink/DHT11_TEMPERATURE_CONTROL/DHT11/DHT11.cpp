#include "DHT11.h" // Encabezado generado por Simulink
#include "Adafruit_Sensor.h"
#include "DHT.h"
#include "DHT_U.h"
#include "Arduino.h"
#define DHTPIN 4
#define DHTTYPE DHT11

// Objeto global de la clase DHT_Unified
DHT_Unified dht(DHTPIN, DHTTYPE);

// Declara una variable para el delay
uint32_t delayMS;

// Función de setup del bloque
void setupFunctionDHT11(uint32_T * BlockParameter, int size_vector__1) {
    Serial.begin(115200);
    dht.begin();
    // Asigna el valor del parámetro del bloque a la variable global
    if (size_vector__1 > 0) {
        delayMS = *BlockParameter;
    }
}
// Función step del bloque
void stepFunctionDHT11(float * Temperatura, int size_vector_1, float * Humedad, int size_vector_2, uint32_T * BlockParameter, int size_vector__1) {
    // Si la lectura es muy rápida, espera el delay configurado
    delay(delayMS);
    sensors_event_t event;
    // Obtener la temperatura
    dht.temperature().getEvent(&event);
    if (!isnan(event.temperature)) {
        *Temperatura = event.temperature;
    }
    // Obtener la humedad
    dht.humidity().getEvent(&event);
    if (!isnan(event.relative_humidity)) {
        *Humedad = event.relative_humidity;
    }
}