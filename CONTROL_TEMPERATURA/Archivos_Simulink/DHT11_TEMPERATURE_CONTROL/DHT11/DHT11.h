/* Copyright 2023 The MathWorks, Inc. */
#ifndef EXAMPLE_H
#define EXAMPLE_H
#if !( defined(MATLAB_MEX_FILE) || defined(RSIM_PARAMETER_LOADING) ||  defined(RSIM_WITH_SL_SOLVER))
#include "rtwtypes.h"
#ifdef __cplusplus
extern "C" {
    #endif
    void stepFunctionDHT11(float * Tempertatura,int size_vector_1,float * Humedad,int size_vector_2, uint32_T * BlockParameter,int size_vector__1);
    void setupFunctionDHT11(uint32_T * BlockParameter,int size_vector__1);
    #ifdef __cplusplus
}
#endif
#else
#define loop(void) (0)
#define setup(void) (0)
#endif
#endif