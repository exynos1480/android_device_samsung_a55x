#include <string>

namespace aidl::vendor::samsung::hardware::keymint {
using namespace std;

class BnSehKeyMintFactory {
    BnSehKeyMintFactory();
    ~BnSehKeyMintFactory();
    void createBinder();
    void getInterfaceHash(basic_string<char, char_traits<char>, allocator<char>>*);
    void getInterfaceVersion(int*);
};

BnSehKeyMintFactory::BnSehKeyMintFactory() {
}

BnSehKeyMintFactory::~BnSehKeyMintFactory() {
}

void BnSehKeyMintFactory::createBinder() {
}

void BnSehKeyMintFactory::getInterfaceHash(basic_string<char, char_traits<char>, allocator<char>>*) {
}

void BnSehKeyMintFactory::getInterfaceVersion(int*) {
}
}
