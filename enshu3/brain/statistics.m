freq = [10.5 11 11.5 11.5 10.5 10.5 10.5 10.5];
power = [192.0 1148 763.1 1009 396.2 712.1 139.2 690.5 ];

freq = freq - mean(freq)
'freq ttest'
ttest(freq)

power = power - mean(freq)
'power ttest'
ttest(power, mean(power))