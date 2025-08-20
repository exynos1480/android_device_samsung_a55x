/*
 * Copyright (C) 2024 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include "TimedRestore.h"
#include <fstream>

TimedRestore::TimedRestore(const std::string& filename)
: filename(filename), saved_value(-1) {
    std::ifstream ifs(filename);
    if (ifs) {
        ifs >> saved_value;
    }
}

TimedRestore::~TimedRestore() {
    if (saved_value >= 0) {
        std::ofstream ofs(filename);
        if (ofs) {
            ofs << saved_value;
        }
    }
}

void TimedRestore::set(const int value) {
	if (saved_value > value) {
        return;
    }
    std::ofstream ofs(filename);
	if (ofs) {
	    ofs << value;
    }
}
