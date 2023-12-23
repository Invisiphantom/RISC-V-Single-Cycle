int sub(int x, int y) { return x - y; }
int sum(int x, int y) { return x + y; }

int main() {
    int a = 1;
    int b = 2;
    int c = sum(a, b);
    c = sub(c, a);
    return c;
}
