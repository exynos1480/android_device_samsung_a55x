namespace android::hardware {
template <typename> struct hidl_vec {
};
}

using android::hardware::hidl_vec;

void hermes_put_persistent_cred(hidl_vec<unsigned char>&, hidl_vec<unsigned char>&) {
}
