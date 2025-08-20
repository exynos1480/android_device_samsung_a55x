/*
 * Copyright (C) 2024 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include <string>

class TimedRestore {
    std::string filename;
    int saved_value;

public:
    TimedRestore() = delete;
    TimedRestore(const std::string& filename);
    ~TimedRestore();

    void set(const int value);
};
