#include <string>

namespace aidl::vendor::samsung::hardware::keymint {
using namespace std;

class BnSehKeyMintExtension {
    BnSehKeyMintExtension();
    ~BnSehKeyMintExtension();
    void createBinder();
    void getInterfaceHash(basic_string<char, char_traits<char>, allocator<char>>*);
    void getInterfaceVersion(int*);
};

BnSehKeyMintExtension::BnSehKeyMintExtension() {
}

BnSehKeyMintExtension::~BnSehKeyMintExtension() {
}

void BnSehKeyMintExtension::createBinder() {
}

void BnSehKeyMintExtension::getInterfaceHash(basic_string<char, char_traits<char>, allocator<char>>*) {
}

void BnSehKeyMintExtension::getInterfaceVersion(int*) {
}
}
