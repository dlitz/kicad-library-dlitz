* dlitz 2024
.subckt vcpwm_sim in vref out out_n vcc gnd freq=1k
.param freq = 1k
.param period = {1/freq}
* in = input voltage (should be between gnd and vref)
* vref = input reference voltage
* out = PWM output
* out_n = PWM output, inverted
* vcc = power
* gnd = ground

.func mod(x, y) = {x - floor(x/y)*y}    ; Modulo operator
.func proportion_of_cycle() = mod(time, period) / period
.func duty_cycle() = V(in) / V(vref)

Eout   out   gnd value={proportion_of_cycle() < duty_cycle() ? V(vcc) : 0}
Eout_n out_n gnd value={proportion_of_cycle() < duty_cycle() ? 0 : V(vcc)}

.ends
