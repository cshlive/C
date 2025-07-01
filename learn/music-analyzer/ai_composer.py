import pandas as pd
import numpy as np
import json
import random
from datetime import datetime

class AIComposer:
    def __init__(self, csv_file='analysis_results.csv'):
        """初始化AI创作助手"""
        self.df = pd.read_csv(csv_file)
        self.feature_columns = [col for col in self.df.columns if col != 'song']
        print(f"🎵 AI创作助手已加载 {len(self.df)} 首参考歌曲")
        
    def analyze_style_patterns(self):
        """分析音乐风格模式"""
        patterns = {}
        
        # BPM模式分析
        bpm_mean = self.df['bpm'].mean()
        bpm_std = self.df['bpm'].std()
        
        if bpm_mean < 80:
            patterns['tempo_style'] = 'Ballad/Slow'
            patterns['mood'] = 'melancholic, emotional, intimate'
        elif bpm_mean < 100:
            patterns['tempo_style'] = 'Mid-tempo'
            patterns['mood'] = 'relaxed, contemplative, smooth'
        elif bpm_mean < 130:
            patterns['tempo_style'] = 'Moderate'
            patterns['mood'] = 'upbeat, comfortable, accessible'
        else:
            patterns['tempo_style'] = 'Fast/Dance'
            patterns['mood'] = 'energetic, exciting, dynamic'
            
        patterns['bpm_range'] = (int(bpm_mean - bpm_std), int(bpm_mean + bpm_std))
        patterns['optimal_bpm'] = int(bpm_mean)
        
        # 节奏特征分析
        onset_mean = self.df['onset_mean'].mean()
        onset_std = self.df['onset_std'].mean()
        
        if onset_mean > 0.5:
            patterns['rhythm_style'] = 'Strong rhythmic emphasis'
            patterns['instruments'] = ['drums', 'percussion', 'bass']
        else:
            patterns['rhythm_style'] = 'Gentle rhythmic flow'
            patterns['instruments'] = ['piano', 'strings', 'acoustic guitar']
            
        # MFCC音色特征
        mfcc_features = [col for col in self.feature_columns if 'mfcc' in col and 'mean' in col]
        mfcc_profile = [self.df[col].mean() for col in mfcc_features]
        
        patterns['timbre_profile'] = mfcc_profile[:8]  # 前8个MFCC系数
        
        return patterns
    
    def generate_composition_template(self, style_name="MyStyle"):
        """生成创作模板"""
        patterns = self.analyze_style_patterns()
        
        template = {
            "composition_info": {
                "style_name": style_name,
                "generated_at": datetime.now().isoformat(),
                "based_on_songs": len(self.df)
            },
            "tempo_guidelines": {
                "bpm": patterns['optimal_bpm'],
                "bpm_range": patterns['bpm_range'],
                "tempo_style": patterns['tempo_style'],
                "mood": patterns['mood']
            },
            "rhythm_guidelines": {
                "style": patterns['rhythm_style'],
                "recommended_instruments": patterns['instruments'],
                "onset_strength": self.df['onset_mean'].mean()
            },
            "harmonic_guidelines": {
                "mel_spectrum_intensity": self.df['mel_mean'].mean(),
                "spectral_complexity": "high" if self.df['mel_std'].mean() > 0.01 else "low",
                "timbre_coefficients": patterns['timbre_profile']
            },
            "structure_suggestions": self.generate_song_structure(patterns['optimal_bpm']),
            "chord_progressions": self.suggest_chord_progressions(patterns['mood']),
            "production_tips": self.generate_production_tips(patterns)
        }
        
        return template
    
    def generate_song_structure(self, bpm):
        """根据BPM生成歌曲结构建议"""
        if bpm < 90:
            # 慢歌结构
            return {
                "intro": "8-16 bars, gentle build",
                "verse": "16 bars, intimate vocals",
                "chorus": "16 bars, emotional peak",
                "bridge": "8 bars, contrast",
                "outro": "fade out or soft ending"
            }
        elif bpm < 120:
            # 中速歌结构
            return {
                "intro": "4-8 bars",
                "verse": "16 bars",
                "pre_chorus": "4-8 bars",
                "chorus": "16 bars",
                "bridge": "8-16 bars",
                "outro": "4-8 bars"
            }
        else:
            # 快歌结构
            return {
                "intro": "4 bars, energetic",
                "verse": "8-16 bars",
                "chorus": "16 bars, catchy hook",
                "drop": "16 bars, high energy",
                "breakdown": "8 bars",
                "outro": "4-8 bars"
            }
    
    def suggest_chord_progressions(self, mood):
        """根据情绪建议和弦进行"""
        progressions = {
            "melancholic": [
                "vi - IV - I - V (Am - F - C - G)",
                "i - VII - VI - VII (Am - G - F - G)",
                "vi - ii - V - I (Am - Dm - G - C)"
            ],
            "emotional": [
                "I - V - vi - IV (C - G - Am - F)",
                "vi - IV - I - V (Am - F - C - G)",
                "I - vi - ii - V (C - Am - Dm - G)"
            ],
            "upbeat": [
                "I - V - vi - IV (C - G - Am - F)",
                "I - vi - IV - V (C - Am - F - G)",
                "vi - IV - I - V (Am - F - C - G)"
            ],
            "energetic": [
                "i - VII - VI - VII (Am - G - F - G)",
                "i - iv - VII - III (Am - Dm - G - C)",
                "i - VI - III - VII (Am - F - C - G)"
            ]
        }
        
        # 根据mood关键词匹配
        for key in progressions:
            if key in mood:
                return progressions[key]
        
        return progressions["emotional"]  # 默认
    
    def generate_production_tips(self, patterns):
        """生成制作建议"""
        tips = []
        
        # 基于节奏强度的建议
        if patterns['rhythm_style'] == 'Strong rhythmic emphasis':
            tips.extend([
                "使用侧链压缩强调节拍",
                "低频部分保持清晰和有力",
                "考虑添加打击乐层次"
            ])
        else:
            tips.extend([
                "使用柔和的压缩比",
                "注重中高频的细节",
                "营造空间感和氛围"
            ])
        
        # 基于BPM的建议
        if patterns['optimal_bpm'] < 90:
            tips.extend([
                "使用长混响营造空间感",
                "慢攻击时间的压缩器",
                "温暖的EQ设置"
            ])
        elif patterns['optimal_bpm'] > 120:
            tips.extend([
                "短混响，保持清晰度",
                "快速攻击的压缩器",
                "明亮的高频处理"
            ])
        
        return tips
    
    def create_melody_guidance(self):
        """创建旋律指导"""
        # 基于MFCC特征创建旋律建议
        mfcc_features = [col for col in self.feature_columns if 'mfcc' in col and 'mean' in col]
        mfcc_values = [self.df[col].mean() for col in mfcc_features[:5]]
        
        guidance = {
            "melodic_contour": "ascending" if mfcc_values[1] > 0 else "descending",
            "note_density": "high" if abs(mfcc_values[2]) > 10 else "moderate",
            "pitch_range": "wide" if abs(mfcc_values[3]) > 15 else "narrow",
            "rhythmic_complexity": "complex" if abs(mfcc_values[4]) > 5 else "simple"
        }
        
        return guidance
    
    def generate_lyrics_theme(self, mood):
        """根据音乐情绪生成歌词主题建议"""
        themes = {
            "melancholic": ["lost love", "nostalgia", "solitude", "reflection"],
            "emotional": ["relationships", "personal growth", "life changes", "hope"],
            "upbeat": ["celebration", "friendship", "adventure", "positivity"],
            "energetic": ["motivation", "success", "party", "freedom"]
        }
        
        for key in themes:
            if key in mood:
                return random.sample(themes[key], 2)
        
        return ["love", "life"]
    
    def save_composition_template(self, template, filename=None):
        """保存创作模板到JSON文件"""
        if filename is None:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            filename = f"composition_template_{timestamp}.json"
        
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(template, f, ensure_ascii=False, indent=2)
        
        print(f"✅ 创作模板已保存到 {filename}")
        return filename
    
    def print_composition_guide(self):
        """打印创作指南"""
        template = self.generate_composition_template()
        patterns = self.analyze_style_patterns()
        
        print("\n" + "="*60)
        print("🎼 AI 音乐创作指南")
        print("="*60)
        
        print(f"\n📊 基于 {len(self.df)} 首你喜欢的歌曲分析")
        
        print(f"\n🎵 节奏设置:")
        print(f"• 推荐BPM: {template['tempo_guidelines']['bpm']}")
        print(f"• BPM范围: {template['tempo_guidelines']['bpm_range'][0]}-{template['tempo_guidelines']['bpm_range'][1]}")
        print(f"• 风格: {template['tempo_guidelines']['tempo_style']}")
        print(f"• 情绪: {template['tempo_guidelines']['mood']}")
        
        print(f"\n🥁 节奏特征:")
        print(f"• 风格: {template['rhythm_guidelines']['style']}")
        print(f"• 推荐乐器: {', '.join(template['rhythm_guidelines']['recommended_instruments'])}")
        
        print(f"\n🎹 和声建议:")
        chord_progs = template['chord_progressions']
        print(f"• 推荐和弦进行:")
        for i, prog in enumerate(chord_progs[:2], 1):
            print(f"  {i}. {prog}")
        
        print(f"\n🎤 歌词主题建议:")
        themes = self.generate_lyrics_theme(template['tempo_guidelines']['mood'])
        print(f"• {', '.join(themes)}")
        
        print(f"\n🎚️ 制作建议:")
        for tip in template['production_tips'][:3]:
            print(f"• {tip}")
        
        melody_guide = self.create_melody_guidance()
        print(f"\n🎼 旋律指导:")
        print(f"• 旋律走向: {melody_guide['melodic_contour']}")
        print(f"• 音符密度: {melody_guide['note_density']}")
        print(f"• 音域范围: {melody_guide['pitch_range']}")
        
        print("\n" + "="*60)
        
        # 保存模板
        filename = self.save_composition_template(template)
        return template, filename

def main():
    """主函数"""
    try:
        composer = AIComposer()
        template, filename = composer.print_composition_guide()
        
        print(f"\n🎉 创作指南生成完成！")
        print(f"详细模板已保存到: {filename}")
        print("\n💡 使用建议:")
        print("1. 根据BPM和情绪设置你的DAW项目")
        print("2. 选择推荐的乐器组合")
        print("3. 尝试建议的和弦进行")
        print("4. 参考制作技巧进行混音")
        
    except FileNotFoundError:
        print("❌ 找不到 analysis_results.csv 文件")
        print("请先运行 analyze.py 生成音乐分析数据")
    except Exception as e:
        print(f"❌ 创作指南生成过程中出现错误: {e}")

if __name__ == "__main__":
    main() 