#define LOG_TAG "libhdrwrapper"

#include <android-base/logging.h>
#include <hardware/exynos/hdrInterface.h>

class libmxhdr {
public:
  libmxhdr(char const *) {};
  virtual ~libmxhdr();
  virtual int getHdrCoefSize(HdrHwId);
  virtual int getLayerNum(HdrHwId);
  virtual int setTargetInfo(HdrTargetInfo *);
  virtual void setHDRlayer(bool);
  virtual void setRenderIntent(int);
  virtual void getAttributes();
  virtual int initHdrCoefBuildup(HdrHwId);
  virtual int isLayerProcessible(int, HdrLayerInfo *);
  virtual bool needHdrProcessing(HdrLayerInfo *);
  virtual int setLayerInfo(int, HdrLayerInfo *, bool);
  virtual int getHdrCoefData(HdrHwId, int, hdrCoefParcel *);
  virtual void setLogLevel(int);
  virtual DebugMode setDebugMode(DebugMode);
};
extern "C" libmxhdr *createInstance();
extern "C" void destroyInstance(libmxhdr *);

class HdrImpl : public hdrInterface {
public:
  HdrImpl() { mImpl = ::createInstance(); };
  ~HdrImpl() override { destroyInstance(mImpl); };

  int getHdrCoefSize(enum HdrHwId hw_id) override {
    return mImpl->getHdrCoefSize(hw_id);
  }

  // per frame setting phase (set when there is any change)
  int setTargetInfo(struct HdrTargetInfo *tInfo) override {
    return mImpl->setTargetInfo(tInfo);
  }
  void setHDRlayer(bool hasHdr) override { mImpl->setHDRlayer(hasHdr); }
  void setRenderIntent(int rendIntent) override {
    mImpl->setRenderIntent(rendIntent);
  }

  // per frame & per layer in between phase
  int initHdrCoefBuildup(enum HdrHwId hw_id) override {
    return mImpl->initHdrCoefBuildup(hw_id);
  }

  // per layer setting phase
  bool needHdrProcessing(struct HdrLayerInfo *lInfo) override {
    ((HdrLayerInfo2 *)lInfo)->brightness = 1.0;
    return mImpl->needHdrProcessing(lInfo);
  }
  int setLayerInfo(int layer_index, struct HdrLayerInfo *lInfo) override {
    ((HdrLayerInfo2 *)lInfo)->brightness = 1.0;
    int bypass = !mImpl->isLayerProcessible(layer_index, lInfo);
    return mImpl->setLayerInfo(layer_index, lInfo, bypass);
  }

  // get coef phase
  int getHdrCoefData(HdrHwId hw_id, int layer_index,
                     hdrCoefParcel *parcel) override {
    return mImpl->getHdrCoefData(hw_id, layer_index, parcel);
  }
  int getHdrCoefData(enum HdrHwId /*hw_id*/,
                     struct hdrCoefParcel * /*parcel*/) override {
    return -1;
  }

  // debug phase
  void setLogLevel(int log_level) override { mImpl->setLogLevel(log_level); }
  void setDebugMode(DebugMode debug_mode) override {
    mImpl->setDebugMode(debug_mode);
  }

private:
  struct HdrLayerInfo2 {
    int dataspace;
    void *static_metadata;
    int static_len;
    void *dynamic_metadata;
    int dynamic_len;
    bool premult_alpha;
    enum HdrBpc bpc;
    enum RenderSource source;
    float *tf_matrix;
    bool bypass;
    float brightness;
  };

  libmxhdr *mImpl;
};

hdrInterface *hdrInterface::createInstance() { return new HdrImpl(); }
