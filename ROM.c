int add(int x, int y) { return x + y; }

int main() {
    int sum = 0;
    for (int i = 1; i <= 5; i++)
        sum += i;
    sum = add(sum, 5);
    return sum;
}
