// This file is part of "bootos"
// Under the MIT License
// Copyright (c) 2022 Antonin Hérault

/**
 * Loaded by "bootos" at 0x1000
 * Prints "hi" at top-left screen for testing
 * */
void _start() {
    *((int*)0xb8000) = 0x07690748;
    for (;;) {}
}
