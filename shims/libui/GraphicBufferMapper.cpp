/*
 * Copyright (C) 2024 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdint.h>
#include <ui/GraphicBufferMapper.h>
#include <ui/Rect.h>
#include <utils/Errors.h>

using android::Rect;
using android::status_t;

extern "C" {
status_t _ZN7android19GraphicBufferMapper9lockAsyncEPK13native_handlemmRKNS_4RectEPPviPiS9_(
        void* thisptr, buffer_handle_t handle, uint64_t producerUsage, uint64_t consumerUsage,
        const Rect& bounds, void** vaddr, int fenceFd, int32_t* /*outBytesPerPixel*/,
        int32_t* /*outBytesPerStride*/) {
    auto* gpm = static_cast<android::GraphicBufferMapper*>(thisptr);
    return gpm->lockAsync(handle, producerUsage, consumerUsage, bounds, vaddr, fenceFd);
}
}
