int ArraySum(int array[], int count)
{
    int sum = 0;

    for (int i = 0; i < count; i++)
        sum += array[i];

    return sum;
}

int main()
{
    int Array[50];

    int sum = ArraySum(Array, 50);
}