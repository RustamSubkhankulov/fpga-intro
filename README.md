### Введение в FPGA и Verilog, ФРКТ МФТИ

#### Список лабораторных работ:
Работы расположены в списке по убыванию их сложности.

1. [Модель процессора архитектуры RISC-V c поддержкой арифметических инструкций, использованием ROM и MMIO](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/07_cpu)
2. [Модуль ROM-памяти, инициализируемый содержимым из файла](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/06_rom)
3. [Детерменированный конечный автомат, описывающий поведение вендингового автомата с напитками](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/03_dfa)
4. [Делитель частоты](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/02_clock_div)
5. [Знаковое расширение константы](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/01_sign_ext)
6. [Инвертор](https://github.com/RustamSubkhankulov/fpga-intro/tree/main/00_invertor)

#### Icarus Verilog и GTKWave
Программа Icarus Verilog это самое простое средство для симуляции Verilog-кода. Установка для Linux возможна с помощью следующих шагов: 
```
sudo apt install iverilog
sudo apt install gtkwave
```

#### Сборка и симуляция
Чтобы воспользоваться симулятором, достаточно использовать команду <code>make test</code> в директории с каким-либо из проектов. Данная команда проводит сначала компиляцию кода при помощи **iverilog**, а далее открывает дамп сигналов при помощи **gtkwave**.
