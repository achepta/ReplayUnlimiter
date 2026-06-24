class ReplaySampleRatePatch {
    uint64 patchPtr = Dev::BaseAddress() + 0x0080FC13;

    void Apply(uint sampleRateMs) {
        Dev::SafeWrite(patchPtr, uint8(0xB8));
        Dev::SafeWrite(patchPtr + 1, sampleRateMs);
        print("Replay sample rate patched to " + sampleRateMs + " ms.");
    }

    void Revert() {
        Dev::SafeWrite(patchPtr + 1, uint(0xFFA75408));
        Dev::SafeWrite(patchPtr, uint8(0xE8));
        print("Replay sample rate patch reverted.");
    }
}
