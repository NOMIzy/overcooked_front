import { useEffect, useRef } from 'react';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

export default function AboutSection() {
  const sectionRef = useRef<HTMLElement>(null);
  const textRef = useRef<HTMLDivElement>(null);
  const videoRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const ctx = gsap.context(() => {
      if (textRef.current) {
        gsap.from(textRef.current, {
          opacity: 0,
          y: 30,
          duration: 0.8,
          ease: 'power2.out',
          scrollTrigger: {
            trigger: textRef.current,
            start: 'top 85%',
          },
        });
      }
      if (videoRef.current) {
        gsap.from(videoRef.current, {
          opacity: 0,
          y: 30,
          duration: 0.8,
          delay: 0.2,
          ease: 'power2.out',
          scrollTrigger: {
            trigger: videoRef.current,
            start: 'top 85%',
          },
        });
      }
    }, sectionRef);

    return () => ctx.revert();
  }, []);

  return (
    <section
      id="about"
      ref={sectionRef}
      style={{
        backgroundColor: '#F1F8F1',
        padding: '120px 24px',
        position: 'relative',
        zIndex: 5,
      }}
    >
      <div
        style={{
          maxWidth: '1280px',
          margin: '0 auto',
          display: 'grid',
          gridTemplateColumns: 'minmax(300px, 40%) 1fr',
          gap: '64px',
          alignItems: 'center',
        }}
      >
        {/* Text Block */}
        <div ref={textRef} style={{ position: 'relative' }}>
          <div
            style={{
              position: 'absolute',
              left: '-24px',
              top: '0',
              bottom: '0',
              width: '4px',
              background: '#4CAF50',
              borderRadius: '2px',
            }}
          />
          <h2
            style={{
              fontFamily: "'Helvetica Neue', 'PingFang SC', 'Microsoft YaHei', sans-serif",
              fontSize: 'clamp(32px, 3vw, 48px)',
              fontWeight: 600,
              lineHeight: 1.2,
              letterSpacing: '-0.5px',
              color: '#2D2D2D',
              marginBottom: '24px',
            }}
          >
            我们的项目
          </h2>
          <p
            style={{
              fontSize: '16px',
              lineHeight: 1.75,
              color: '#2D2D2D',
              marginBottom: '20px',
            }}
          >
            我们是「胡闹厨房：Cook with Robot」黑客松的参赛选手。在48小时的极限挑战中，我们基于 reBot Arm B601-DM 开源机械臂、reComputer Robotics Jetson 边缘计算机，以及奥比中光 Gemini2 深度相机，从零构建了一套完整的AI主厨系统。
          </p>
          <p
            style={{
              fontSize: '16px',
              lineHeight: 1.75,
              color: '#666666',
              marginBottom: '24px',
            }}
          >
            我们的目标是实现两道经典中式菜肴的全自动烹饪：可乐鸡翅与蛋炒饭。从食材识别、轨迹规划到精准控制，让机械臂真正走进厨房，完成从原材料到成品的全流程自动化。
          </p>
          <div style={{ display: 'flex', gap: '24px', flexWrap: 'wrap' }}>
            <div>
              <div
                style={{
                  fontSize: '36px',
                  fontWeight: 700,
                  color: '#4CAF50',
                  fontFamily: "'Helvetica Neue', sans-serif",
                }}
              >
                2
              </div>
              <div style={{ fontSize: '14px', color: '#666666' }}>道菜品</div>
            </div>
            <div>
              <div
                style={{
                  fontSize: '36px',
                  fontWeight: 700,
                  color: '#FF9800',
                  fontFamily: "'Helvetica Neue', sans-serif",
                }}
              >
                6DoF
              </div>
              <div style={{ fontSize: '14px', color: '#666666' }}>机械臂</div>
            </div>
            <div>
              <div
                style={{
                  fontSize: '36px',
                  fontWeight: 700,
                  color: '#4CAF50',
                  fontFamily: "'Helvetica Neue', sans-serif",
                }}
              >
                全开源
              </div>
              <div style={{ fontSize: '14px', color: '#666666' }}>技术栈</div>
            </div>
          </div>
        </div>

        {/* Video Block */}
        <div ref={videoRef}>
          <video
            autoPlay
            muted
            loop
            playsInline
            style={{
              width: '100%',
              borderRadius: '16px',
              boxShadow: '0 20px 60px rgba(0,0,0,0.15)',
              objectFit: 'cover',
              aspectRatio: '16/9',
            }}
          >
            <source src="/videos/robot-arm-motion.mp4" type="video/mp4" />
          </video>
        </div>
      </div>
    </section>
  );
}
