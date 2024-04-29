### Реализация интерфейса UART на языке **Verilog**

Универсальный асинхронный приёмопередатчик (**УАПП**, англ. Universal Asynchronous Receiver-Transmitter, **UART**) — узел вычислительных устройств, предназначенный для организации связи с другими цифровыми устройствами. Преобразует передаваемые данные в последовательный вид так, чтобы было возможно передать их по одной физической цифровой линии другому аналогичному устройству. Метод преобразования хорошо стандартизован и широко применяется в компьютерной технике.

## Модули на языке Verilog: 
- **rom.v** - ROM-память, инициализирующася из файла **misc/rom_contents.txt**
- **rom_fetcher.v** - модуль, последовательно считывающий содержимое ROM
- **clock_div.v** - делитель частоты
- **uart_tx.v** - transmitter UART
- **uart_rx.v** - receiver UART
- **testbench.v** - тестовый модуль, запускающий симуляцию 