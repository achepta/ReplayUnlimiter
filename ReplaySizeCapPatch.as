class ReplaySizeCapPatch {
    uint64 capValuePtr = Dev::BaseAddress() + 0x01201217;

    void Apply(uint sizeMiB) {
        Dev::SafeWrite(capValuePtr, uint(sizeMiB * 1024 * 1024));
        print("Replay size cap patched to " + sizeMiB + " MiB.");
    }

    void Revert() {
        Dev::SafeWrite(capValuePtr, uint(0x00430440));
        print("Replay size cap patch reverted.");
    }
}
