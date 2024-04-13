typedef unsigned int uint32_t;
typedef unsigned char uint8_t;

#define OUT_ADDR ((volatile uint32_t *)0x20)

void main() {
    uint32_t first = 0, second = 1, next, i = 0;

    for (i = 0; i != 12; i++) {
        next = first + second;
        *OUT_ADDR = next;
        first = second;
        second = next;
    }
}
