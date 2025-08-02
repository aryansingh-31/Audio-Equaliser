
# Hi, I'm Aryan!


## 🚀 About This Repository - 
This was the Project for my Digital Signal Processing Course which was in the 4th Semester of my Engineering.


# Audio Equalizer using Matlab

An equalizer (also called an “EQ”) is an audio filter that isolates certain frequencies and either boosts them, lowers them, or leaves them unchanged. Equalizers are found on a wide array of electronic devices. These include: Home stereo systems, Car stereo systems, cell phones and tablets, Instrumental amplifiers (guitar, bass, keyboard, etc.)​

An equalizer could make vocals more articulate by boosting the treble frequency range. It could make a song sound “heavier” by boosting bass frequencies. Sometimes, it can be used to remove certain sounds from a recording, like the high pitched buzz of a fluorescent lighting fixture.​


## Objectives of the Project

- Develop an audio equalizer using Matlab.​

- Implement a splitter feature to separate vocals and instrumental components within audio tracks.​

- Implement input handling for audio files.​

- Create a user-friendly interface with adjustable frequency sliders.​

- Apply DSP concepts to modify audio based on slider adjustments.​

- Provide real-time audio feedback.​

- Enhance user experience through visualizations and presets.​


## DSP Concepts Used

```Audio Sampling - ```

Audio signals are continuous waveforms representing sound. In digital signal processing, these signals are converted into a discrete-time representation through sampling.​

Sampling involves measuring the amplitude of the audio signal at regular intervals in time.​

The resulting sampled signal is a sequence of discrete amplitude values representing the original continuous signal at specific points in time.​

```Filtering - ``` ​

Filtering is a fundamental operation in DSP that modifies the frequency content of a signal.​

The code applies the designed Butterworth filter to the input audio signal using the ‘filtfilt’ function.​

‘Filtfilt’ performs zero-phase digital filtering, meaning it applies the filter twice in both forward and reverse directions to eliminate phase distortion and ensure the filter's response is symmetrical.

```Butterworth Filter Design - ```​

The code designs a Butterworth filter, which is a type of Infinite Impulse Response (IIR) filter.​

Butterworth filters are characterized by a maximally flat frequency response in the passband and a gradual roll-off in the stopband.​

The filter is designed using the butter function, specifying the filter order and the desired passband frequencies to isolate specific frequency components (vocals) and attenuate others (noise).​

```FFT (Fast Fourier Transform) - ``` ​

The FFT is an efficient algorithm for computing the frequency spectrum of a signal.​

It decomposes a signal into its constituent frequency components, providing insight into the signal's frequency content.​

The code computes the FFT of the filtered audio signal to visualize its frequency spectrum and verify the effectiveness of the filtering process.​



​


## Installation

1. Clone the repository:

```bash
  https://github.com/adarsh-naik-2004/Audio-Equalizer-using-Matlab.git
```

2. Run the file in Matlab.
    
## Screenshots

![dsp1](https://github.com/adarsh-naik-2004/Audio-Equalizer-using-Matlab/assets/130145440/1e15a620-ba4f-44f6-853f-c4dc1d97f97e)


![dsp2](https://github.com/adarsh-naik-2004/Audio-Equalizer-using-Matlab/assets/130145440/0efc2cdf-422b-4a22-946c-32329e655fd6)


## License

[MIT](https://github.com/adarsh-naik-2004/Audio-Equalizer-using-Matlab/blob/main/LICENSE)


## 🔗 Links
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/adarsh-manjunath-naik-a2004m/)

