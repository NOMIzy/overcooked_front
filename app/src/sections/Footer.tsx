export default function Footer() {
  return (
    <footer
      id="footer"
      style={{
        backgroundColor: '#0A0A0A',
        borderTop: '1px solid #4CAF50',
        padding: '80px 24px 40px',
        position: 'relative',
        zIndex: 5,
      }}
    >
      <div
        style={{
          maxWidth: '1280px',
          margin: '0 auto',
          display: 'grid',
          gridTemplateColumns: '1fr 1fr',
          gap: '64px',
          alignItems: 'start',
        }}
      >
        {/* Left: Slogan */}
        <div>
          <h3
            style={{
              fontFamily: "'Helvetica Neue', 'PingFang SC', 'Microsoft YaHei', sans-serif",
              fontSize: 'clamp(28px, 3vw, 42px)',
              fontWeight: 700,
              color: '#FFFFFF',
              lineHeight: 1.2,
              marginBottom: '16px',
            }}
          >
            好菜，"臂" 需有讲究
          </h3>
          <p
            style={{
              fontSize: '16px',
              color: 'rgba(255,255,255,0.5)',
              lineHeight: 1.75,
              maxWidth: '400px',
            }}
          >
            胡闹厨房黑客松参赛项目 · 基于 reBot + Gemini2 + Jetson 的 AI 主厨系统
          </p>
        </div>

        {/* Right: Resources & Contact */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '40px' }}>
          {/* Resources */}
          <div>
            <h4
              style={{
                fontSize: '14px',
                fontWeight: 600,
                color: 'rgba(255,255,255,0.4)',
                textTransform: 'uppercase',
                letterSpacing: '1px',
                marginBottom: '20px',
              }}
            >
              参考资源
            </h4>
            <div style={{ display: 'flex', gap: '16px', alignItems: 'center', flexWrap: 'wrap' }}>
              {['Seeed Studio', 'Orbbec', 'NVIDIA'].map((partner) => (
                <div
                  key={partner}
                  style={{
                    background: 'rgba(255,255,255,0.05)',
                    border: '1px solid rgba(255,255,255,0.1)',
                    padding: '12px 24px',
                    borderRadius: '8px',
                    color: '#E5E5E5',
                    fontSize: '14px',
                    fontWeight: 500,
                  }}
                >
                  {partner}
                </div>
              ))}
            </div>
          </div>

          {/* Links */}
          <div>
            <h4
              style={{
                fontSize: '14px',
                fontWeight: 600,
                color: 'rgba(255,255,255,0.4)',
                textTransform: 'uppercase',
                letterSpacing: '1px',
                marginBottom: '20px',
              }}
            >
              相关链接
            </h4>
            <div style={{ display: 'flex', gap: '24px', flexWrap: 'wrap' }}>
              {[
                { label: '比赛官网', href: 'https://orbbec.com.cn/index/News/info.html?cate=31&id=363' },
                { label: 'reBot 文档', href: 'https://wiki.seeedstudio.com/rebot_arm_b601_dm_lerobot/' },
                { label: 'LeRobot', href: 'https://huggingface.co/lerobot' },
                { label: 'Seeed Studio', href: 'https://www.seeedstudio.com/' },
              ].map((link) => (
                <a
                  key={link.label}
                  href={link.href}
                  target="_blank"
                  rel="noopener noreferrer"
                  style={{
                    color: 'rgba(255,255,255,0.6)',
                    fontSize: '14px',
                    textDecoration: 'none',
                    transition: 'color 0.3s',
                  }}
                  onMouseEnter={(e) => (e.currentTarget.style.color = '#4CAF50')}
                  onMouseLeave={(e) => (e.currentTarget.style.color = 'rgba(255,255,255,0.6)')}
                >
                  {link.label} →
                </a>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Bottom Bar */}
      <div
        style={{
          maxWidth: '1280px',
          margin: '60px auto 0',
          paddingTop: '24px',
          borderTop: '1px solid rgba(255,255,255,0.1)',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          flexWrap: 'wrap',
          gap: '16px',
        }}
      >
        <span style={{ fontSize: '13px', color: 'rgba(255,255,255,0.3)' }}>
          © 2026 胡闹厨房黑客松参赛项目. All rights reserved.
        </span>
        <span style={{ fontSize: '13px', color: 'rgba(255,255,255,0.3)' }}>
          Built with reBot · Gemini2 · Jetson
        </span>
      </div>
    </footer>
  );
}
