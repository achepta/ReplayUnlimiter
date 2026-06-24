const uint REPLAY_SIZE_MIN_MIB = 256;
const uint REPLAY_SIZE_MAX_MIB = 1024;
const uint REPLAY_SIZE_STEP_MIB = 16;
const uint REPLAY_SIZE_STEP_COUNT = (REPLAY_SIZE_MAX_MIB - REPLAY_SIZE_MIN_MIB) / REPLAY_SIZE_STEP_MIB;

const uint SAMPLE_RATE_MIN_MS = 10;
const uint SAMPLE_RATE_MAX_MS = 100;
const uint SAMPLE_RATE_STEP_MS = 10;
const uint SAMPLE_RATE_STEP_COUNT = ( SAMPLE_RATE_MAX_MS - SAMPLE_RATE_MIN_MS) / SAMPLE_RATE_STEP_MS;

ReplaySizeCapPatch@ g_ReplaySizeCapPatch;
ReplaySampleRatePatch@ g_ReplaySampleRatePatch;

void Main() {
    @g_ReplaySizeCapPatch = ReplaySizeCapPatch();
    @g_ReplaySampleRatePatch = ReplaySampleRatePatch();
    ApplySettings();
}


void OnSettingsChanged() {
    ApplySettings();
}

void OnDestroyed() {
    g_ReplaySampleRatePatch.Revert();
    g_ReplaySizeCapPatch.Revert();
}

void ApplySettings() {
    g_ReplaySizeCapPatch.Apply(Setting_ReplaySizeCap);
    g_ReplaySampleRatePatch.Apply(Setting_ReplaySampleRate);
}

[SettingsTab name="Essential Patches"]
void RenderSettings() {
    int sizeCapStep = (Setting_ReplaySizeCap - REPLAY_SIZE_MIN_MIB) / REPLAY_SIZE_STEP_MIB;
    UI::Text("Replay size cap: " + Setting_ReplaySizeCap + " MiB");
    int newSizeCapStep = UI::SliderInt("##SizeCap", sizeCapStep, 0, REPLAY_SIZE_STEP_COUNT, "");
    if (newSizeCapStep != sizeCapStep) {
        Setting_ReplaySizeCap = REPLAY_SIZE_MIN_MIB + newSizeCapStep * REPLAY_SIZE_STEP_MIB;
        ApplySettings();
    }

    int sampleRateStep = (Setting_ReplaySampleRate - SAMPLE_RATE_MIN_MS) / SAMPLE_RATE_STEP_MS;
    UI::Text("Replay sample rate: " + Setting_ReplaySampleRate + " ms");
    int newSampleRateStep = UI::SliderInt("##SampleRate", sampleRateStep, 0, SAMPLE_RATE_STEP_COUNT, "");
    if (newSampleRateStep != sampleRateStep) {
        Setting_ReplaySampleRate = SAMPLE_RATE_MIN_MS + newSampleRateStep * SAMPLE_RATE_STEP_MS;
        ApplySettings();
    }
}