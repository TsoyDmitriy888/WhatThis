def calculate_control_digit():
    # Храним ИИН как список цифр
    iin_digits = [0, 0, 0, 1, 2, 8, 5, 0, 0, 4, 1]
    weights1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

    # Шаг 1.1 - сумма произведений
    S = 0
    for i in range(11):
        S += iin_digits[i] * weights1[i]

    # Шаг 1.2-1.4 - вычисление контрольного числа
    C = S // 11  # Целочисленное деление в Python
    K = S - C * 11

    # Шаг 1.5 - проверка результата
    print(f"S = {S}")
    print(f"C = {C}")
    print(f"K = {K}")

    if K < 10:
        print(f"Контрольное число: {K}")
    else:
        print("Нужен второй проход с весами от 3")
        weights2 = [3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2]

        # Шаг 1.1 - сумма произведений (второй проход)
        S1 = 0
        for i in range(11):
            S1 += iin_digits[i] * weights2[i]

        C1 = S1 // 11
        K1 = S1 - C1 * 11

        print(f"S = {S1}")
        print(f"C = {C1}")
        print(f"K = {K1}")


# Вызов функции
calculate_control_digit()