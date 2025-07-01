import librosa
import librosa.display
import matplotlib.pyplot as plt
import pandas as pd
import os
import numpy as np
import time

# 歌曲文件夹
SONG_DIR = 'songs'
results = []

for filename in os.listdir(SONG_DIR):
    if not filename.lower().endswith(('.mp3', '.wav', '.flac', '.ogg')):
        continue
    path = os.path.join(SONG_DIR, filename)
    print(f'正在分析: {filename}')
    y, sr = librosa.load(path)
    tempo, beat_frames = librosa.beat.beat_track(y=y, sr=sr)
    # 修复：如果tempo是数组，取第一个元素
    if isinstance(tempo, np.ndarray):
        tempo = tempo[0]
    tempo = float(tempo)
    onset_env = librosa.onset.onset_strength(y=y, sr=sr)
    beat_times = librosa.frames_to_time(beat_frames, sr=sr)

    # 1. 梅尔频谱
    S = librosa.feature.melspectrogram(y=y, sr=sr, n_mels=128)
    mel_mean = np.mean(S)
    mel_std = np.std(S)

    # 2. MFCC
    mfcc = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=13)
    mfcc_mean = np.mean(mfcc, axis=1)  # 每个MFCC分量的均值
    mfcc_std = np.std(mfcc, axis=1)    # 每个MFCC分量的方差

    # 3. 节奏强度变化
    onset_diff = np.diff(onset_env)
    onset_diff_mean = np.mean(onset_diff)
    onset_diff_std = np.std(onset_diff)

    results.append({
        'song': filename,
        'bpm': tempo,
        'beat_count': len(beat_times),
        'onset_mean': onset_env.mean(),
        'onset_std': onset_env.std(),
        'mel_mean': mel_mean,
        'mel_std': mel_std,
        'onset_diff_mean': onset_diff_mean,
        'onset_diff_std': onset_diff_std,
        **{f'mfcc{i+1}_mean': mfcc_mean[i] for i in range(len(mfcc_mean))},
        **{f'mfcc{i+1}_std': mfcc_std[i] for i in range(len(mfcc_std))}
    })
    # 可视化
    plt.figure(figsize=(14, 5))
    librosa.display.waveshow(y, sr=sr, alpha=0.6)
    plt.vlines(beat_times, -1, 1, color='r', alpha=0.8, linestyle='--', label='Beats')
    plt.title(f'{filename} - BPM: {tempo:.2f}')
    plt.legend()
    plt.savefig(f'output_{filename}.png')
    plt.close()

    # 梅尔频谱图
    plt.figure(figsize=(10, 4))
    librosa.display.specshow(librosa.power_to_db(S, ref=np.max), sr=sr, y_axis='mel', x_axis='time')
    plt.title(f'Mel Spectrogram: {filename}')
    plt.colorbar(format='%+2.0f dB')
    plt.tight_layout()
    plt.savefig(f'mel_{filename}.png')
    plt.close()

    # MFCC图
    plt.figure(figsize=(10, 4))
    librosa.display.specshow(mfcc, x_axis='time')
    plt.colorbar()
    plt.title(f'MFCC: {filename}')
    plt.tight_layout()
    plt.savefig(f'mfcc_{filename}.png')
    plt.close()

# 保存分析结果到表格
df = pd.DataFrame(results)

# 添加错误处理机制
try:
    df.to_csv('analysis_results.csv', index=False)
    print('分析完成，结果已保存到 analysis_results.csv')
except PermissionError:
    print('无法写入 analysis_results.csv，可能文件正在被其他程序使用')
    print('请关闭Excel或其他程序后重试，或者使用不同的文件名')
    # 尝试用时间戳作为文件名
    timestamp = int(time.time())
    backup_filename = f'analysis_results_{timestamp}.csv'
    df.to_csv(backup_filename, index=False)
    print(f'结果已保存到 {backup_filename}')

print(df)