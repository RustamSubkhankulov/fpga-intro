### Введение в FPGA и Verilog, ФРКТ МФТИ

#### Однотактовый RISC-V процессор
[Модель процессора архитектуры RISC-V на языке **Verilog** с поддержкой ограниченного подмножества инструкций](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/cpu)

#### Интерфейс UART
[Реализация интерфейса UART на языке **Verilog**](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/uart)

#### Список прочих лабораторные работы:

1. [Модуль ROM-памяти, инициализируемый содержимым из файла](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/rom)
2. [Детерменированный конечный автомат, описывающий поведение вендингового автомата с напитками](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/dfa)
3. [Делитель частоты](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/clock_div)
4. [Знаковое расширение константы](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/sign_ext)
5. [Инвертор](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/invertor)

#### Icarus Verilog и GTKWave
Программа Icarus Verilog это самое простое средство для симуляции Verilog-кода. Установка для Linux возможна с помощью следующих шагов: 
```
sudo apt install iverilog
sudo apt install gtkwave
```

#### Сборка и симуляция
Чтобы воспользоваться симулятором, достаточно использовать команду <code>make test</code> в директории с каким-либо из проектов. Данная команда проводит сначала компиляцию кода при помощи **iverilog**, а далее открывает дамп сигналов при помощи **gtkwave**.

![GTKWave](https://github.com/RustamSubkhankulov/fpga-intro/blob/main/pics/gtkwave.png)
