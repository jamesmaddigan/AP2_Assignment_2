/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin processor.

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>
class Delay;

//==============================================================================
/**
*/
class Analog_Delay_AP2AudioProcessor  : public juce::AudioProcessor
{
public:
    //==============================================================================
    Analog_Delay_AP2AudioProcessor();
    ~Analog_Delay_AP2AudioProcessor() override;

    //==============================================================================
    void prepareToPlay (double sampleRate, int samplesPerBlock) override;
    void releaseResources() override;

   #ifndef JucePlugin_PreferredChannelConfigurations
    bool isBusesLayoutSupported (const BusesLayout& layouts) const override;
   #endif

    void processBlock (juce::AudioBuffer<float>&, juce::MidiBuffer&) override;

    //==============================================================================
    juce::AudioProcessorEditor* createEditor() override;
    bool hasEditor() const override;

    //==============================================================================
    const juce::String getName() const override;

    bool acceptsMidi() const override;
    bool producesMidi() const override;
    bool isMidiEffect() const override;
    double getTailLengthSeconds() const override;

    //==============================================================================
    int getNumPrograms() override;
    int getCurrentProgram() override;
    void setCurrentProgram (int index) override;
    const juce::String getProgramName (int index) override;
    void changeProgramName (int index, const juce::String& newName) override;

    //==============================================================================
    void getStateInformation (juce::MemoryBlock& destData) override;
    void setStateInformation (const void* data, int sizeInBytes) override;
    
    

private:
    //==============================================================================
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (Analog_Delay_AP2AudioProcessor)
    Delay* analogDelayLine;
    
    juce::AudioProcessorValueTreeState parameters;
    
    std::atomic<float>* delayTimeParameter = nullptr;
    std::atomic<float>* feedbackParameter = nullptr;
    std::atomic<float>* driveParameter = nullptr;
    std::atomic<float>* breakUpParameter = nullptr;
    std::atomic<float>* cutOffParameter = nullptr;
    std::atomic<float>* multiTapButtonState = nullptr;
    std::atomic<float>* multiTapParameter = nullptr;
    std::atomic<float>* multiTapIntensityParameter = nullptr;

    float delayPrevious;
    float multiTapDelayPrevious;
};
