import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
import warnings
warnings.filterwarnings('ignore')

# 设置中文字体
plt.rcParams['font.sans-serif'] = ['SimHei', 'Microsoft YaHei']
plt.rcParams['axes.unicode_minus'] = False

class MusicPatternAnalyzer:
    def __init__(self, csv_file='analysis_results.csv'):
        """初始化音乐模式分析器"""
        self.df = pd.read_csv(csv_file)
        self.feature_columns = [col for col in self.df.columns if col != 'song']
        print(f"已加载 {len(self.df)} 首歌曲的数据")
        print(f"特征数量: {len(self.feature_columns)}")
    
    def basic_statistics(self):
        """基础统计分析"""
        print("\n=== 基础统计信息 ===")
        
        # BPM分析
        bpm_stats = self.df['bpm'].describe()
        print(f"\nBPM统计:")
        print(f"平均BPM: {bpm_stats['mean']:.1f}")
        print(f"BPM范围: {bpm_stats['min']:.1f} - {bpm_stats['max']:.1f}")
        print(f"BPM标准差: {bpm_stats['std']:.1f}")
        
        # 节奏强度分析
        onset_stats = self.df['onset_mean'].describe()
        print(f"\n节奏强度统计:")
        print(f"平均节奏强度: {onset_stats['mean']:.3f}")
        print(f"节奏强度范围: {onset_stats['min']:.3f} - {onset_stats['max']:.3f}")
        
        return bpm_stats, onset_stats
    
    def correlation_analysis(self):
        """相关性分析 - 发现特征之间的关系"""
        print("\n=== 特征相关性分析 ===")
        
        # 计算相关矩阵
        correlation_matrix = self.df[self.feature_columns].corr()
        
        # 找出强相关的特征对
        strong_correlations = []
        for i in range(len(correlation_matrix.columns)):
            for j in range(i+1, len(correlation_matrix.columns)):
                corr_value = correlation_matrix.iloc[i, j]
                if abs(corr_value) > 0.7:  # 强相关阈值
                    strong_correlations.append({
                        'feature1': correlation_matrix.columns[i],
                        'feature2': correlation_matrix.columns[j],
                        'correlation': corr_value
                    })
        
        print("强相关特征对:")
        for corr in sorted(strong_correlations, key=lambda x: abs(x['correlation']), reverse=True):
            print(f"{corr['feature1']} <-> {corr['feature2']}: {corr['correlation']:.3f}")
        
        # 可视化相关矩阵
        plt.figure(figsize=(15, 12))
        sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', center=0, fmt='.2f')
        plt.title('音乐特征相关性矩阵')
        plt.tight_layout()
        plt.savefig('correlation_matrix.png', dpi=300, bbox_inches='tight')
        plt.close()
        
        return correlation_matrix
    
    def clustering_analysis(self, n_clusters=3):
        """聚类分析 - 发现相似的音乐风格"""
        print(f"\n=== 聚类分析 (分为{n_clusters}类) ===")
        
        # 标准化特征
        scaler = StandardScaler()
        features_scaled = scaler.fit_transform(self.df[self.feature_columns])
        
        # K-means聚类
        kmeans = KMeans(n_clusters=n_clusters, random_state=42)
        clusters = kmeans.fit_predict(features_scaled)
        
        # 添加聚类结果到数据框
        self.df['cluster'] = clusters
        
        # 分析每个聚类的特征
        for i in range(n_clusters):
            cluster_data = self.df[self.df['cluster'] == i]
            print(f"\n聚类 {i} ({len(cluster_data)} 首歌):")
            print("歌曲:", list(cluster_data['song']))
            print(f"平均BPM: {cluster_data['bpm'].mean():.1f}")
            print(f"平均节奏强度: {cluster_data['onset_mean'].mean():.3f}")
            print(f"平均梅尔频谱: {cluster_data['mel_mean'].mean():.3f}")
        
        # 可视化聚类结果 (使用PCA降维)
        pca = PCA(n_components=2)
        features_pca = pca.fit_transform(features_scaled)
        
        plt.figure(figsize=(10, 8))
        colors = ['red', 'blue', 'green', 'orange', 'purple']
        for i in range(n_clusters):
            mask = clusters == i
            plt.scatter(features_pca[mask, 0], features_pca[mask, 1], 
                       c=colors[i], label=f'聚类 {i}', alpha=0.7, s=100)
        
        plt.xlabel(f'主成分1 (解释方差: {pca.explained_variance_ratio_[0]:.2%})')
        plt.ylabel(f'主成分2 (解释方差: {pca.explained_variance_ratio_[1]:.2%})')
        plt.title('音乐风格聚类可视化')
        plt.legend()
        plt.grid(True, alpha=0.3)
        plt.savefig('clustering_visualization.png', dpi=300, bbox_inches='tight')
        plt.close()
        
        return clusters, kmeans, scaler
    
    def feature_importance_analysis(self):
        """特征重要性分析"""
        print("\n=== 特征重要性分析 ===")
        
        # 计算每个特征的变异系数 (标准差/均值)
        feature_importance = {}
        for col in self.feature_columns:
            if self.df[col].mean() != 0:
                cv = self.df[col].std() / abs(self.df[col].mean())
                feature_importance[col] = cv
        
        # 排序并显示
        sorted_features = sorted(feature_importance.items(), key=lambda x: x[1], reverse=True)
        
        print("特征变异性排序 (变异性越大，区分度越高):")
        for feature, importance in sorted_features[:10]:
            print(f"{feature}: {importance:.3f}")
        
        # 可视化特征重要性
        features, importances = zip(*sorted_features[:15])
        plt.figure(figsize=(12, 8))
        plt.barh(range(len(features)), importances)
        plt.yticks(range(len(features)), features)
        plt.xlabel('变异系数')
        plt.title('音乐特征重要性分析')
        plt.tight_layout()
        plt.savefig('feature_importance.png', dpi=300, bbox_inches='tight')
        plt.close()
        
        return sorted_features
    
    def generate_creation_suggestions(self):
        """基于分析结果生成创作建议"""
        print("\n=== 🎵 音乐创作建议 ===")
        
        # 分析你喜欢的音乐的共同特征
        bpm_mean = self.df['bpm'].mean()
        bpm_std = self.df['bpm'].std()
        
        onset_mean = self.df['onset_mean'].mean()
        onset_std = self.df['onset_std'].mean()
        
        mel_mean = self.df['mel_mean'].mean()
        
        print(f"\n🎼 根据你喜欢的 {len(self.df)} 首歌分析:")
        print(f"• 推荐BPM范围: {bpm_mean-bpm_std:.0f} - {bpm_mean+bpm_std:.0f}")
        print(f"• 最佳BPM: {bpm_mean:.0f}")
        
        if bpm_mean < 90:
            print("• 风格倾向: 慢歌/抒情 (适合深度情感表达)")
        elif bpm_mean < 120:
            print("• 风格倾向: 中速/流行 (适合日常聆听)")
        else:
            print("• 风格倾向: 快歌/舞曲 (适合运动和派对)")
        
        print(f"\n🎹 音色建议:")
        if onset_mean > 0.5:
            print("• 节奏感强烈，适合加入打击乐器")
        else:
            print("• 节奏柔和，适合弦乐和钢琴主导")
        
        if mel_mean > 0.01:
            print("• 频谱丰富，可以使用复杂和声")
        else:
            print("• 频谱简洁，适合简单旋律线")
        
        # MFCC特征分析
        mfcc_features = [col for col in self.feature_columns if 'mfcc' in col and 'mean' in col]
        mfcc_profile = [self.df[col].mean() for col in mfcc_features]
        
        print(f"\n🎨 创作参数模板:")
        print(f"• BPM: {bpm_mean:.0f}")
        print(f"• 节奏强度: {onset_mean:.3f}")
        print(f"• 梅尔频谱强度: {mel_mean:.6f}")
        print("• MFCC特征向量:", [f"{x:.3f}" for x in mfcc_profile[:5]])
    
    def save_analysis_report(self):
        """保存完整分析报告"""
        report = []
        report.append("# 音乐分析报告\n")
        report.append(f"分析歌曲数量: {len(self.df)}\n")
        report.append(f"分析时间: {pd.Timestamp.now()}\n\n")
        
        # 添加统计信息
        report.append("## 基础统计\n")
        report.append(f"平均BPM: {self.df['bpm'].mean():.1f}\n")
        report.append(f"BPM标准差: {self.df['bpm'].std():.1f}\n")
        report.append(f"平均节奏强度: {self.df['onset_mean'].mean():.3f}\n\n")
        
        # 保存报告
        with open('music_analysis_report.md', 'w', encoding='utf-8') as f:
            f.writelines(report)
        
        print("完整分析报告已保存到 music_analysis_report.md")

def main():
    """主函数"""
    try:
        # 创建分析器
        analyzer = MusicPatternAnalyzer()
        
        # 执行各种分析
        analyzer.basic_statistics()
        analyzer.correlation_analysis()
        analyzer.clustering_analysis(n_clusters=3)
        analyzer.feature_importance_analysis()
        analyzer.generate_creation_suggestions()
        analyzer.save_analysis_report()
        
        print(f"\n🎉 分析完成！生成的文件:")
        print("• correlation_matrix.png - 特征相关性热力图")
        print("• clustering_visualization.png - 风格聚类图")
        print("• feature_importance.png - 特征重要性图")
        print("• music_analysis_report.md - 完整分析报告")
        
    except FileNotFoundError:
        print("❌ 找不到 analysis_results.csv 文件")
        print("请先运行 analyze.py 生成音乐分析数据")
    except Exception as e:
        print(f"❌ 分析过程中出现错误: {e}")

if __name__ == "__main__":
    main() 