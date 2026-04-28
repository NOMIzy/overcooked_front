import { useEffect, useRef } from 'react';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

const DISH_IMAGES = [
  { src: '/images/cola-wings-v2-01.jpg', title: '可乐鸡翅', desc: '食材准备' },
  { src: '/images/cola-wings-v2-02.jpg', title: '可乐鸡翅', desc: '焯水去腥' },
  { src: '/images/cola-wings-v2-03.jpg', title: '可乐鸡翅', desc: '煎制上色' },
  { src: '/images/cola-wings-v2-04.jpg', title: '可乐鸡翅', desc: '可乐炖煮' },
  { src: '/images/cola-wings-v2-05.jpg', title: '可乐鸡翅', desc: '出锅装盘' },
  { src: '/images/egg-rice-v2-01.jpg', title: '蛋炒饭', desc: '备料打蛋' },
  { src: '/images/egg-rice-v2-02.jpg', title: '蛋炒饭', desc: '热油炒饭' },
  { src: '/images/egg-rice-v2-03.jpg', title: '蛋炒饭', desc: '蛋液包裹' },
  { src: '/images/egg-rice-v2-04.jpg', title: '蛋炒饭', desc: '调味撒葱' },
  { src: '/images/egg-rice-v2-05.jpg', title: '蛋炒饭', desc: '成品展示' },
];

export default function DishGallery() {
  const wrapperRef = useRef<HTMLElement>(null);
  const innerRef = useRef<HTMLDivElement>(null);
  const tlRef = useRef<gsap.core.Timeline | null>(null);

  useEffect(() => {
    const wrapper = wrapperRef.current;
    const galleryInner = innerRef.current;
    if (!wrapper || !galleryInner) return;

    // Build gallery items
    galleryInner.innerHTML = '';
    DISH_IMAGES.forEach((dish) => {
      const container = document.createElement('div');
      container.className = 'gallery-image-container';

      const img = document.createElement('img');
      img.src = dish.src;
      img.alt = dish.title;
      img.draggable = false;

      const info = document.createElement('span');
      info.className = 'info';
      info.textContent = `${dish.title} · ${dish.desc}`;

      container.appendChild(img);
      container.appendChild(info);
      galleryInner.appendChild(container);
    });

    const imageWidth = (galleryInner.children[0] as HTMLElement)?.offsetWidth || 300;
    const cloneCount = Math.ceil(window.innerWidth / imageWidth) + 1;

    for (let i = 0; i < cloneCount; i++) {
      const original = galleryInner.children[i];
      if (original) {
        galleryInner.appendChild(original.cloneNode(true));
      }
    }

    const ctx = gsap.context(() => {
      const tl = gsap.timeline();
      tl.to(galleryInner, {
        xPercent: -100,
        repeat: -1,
        ease: 'none',
        duration: 30,
      });
      tlRef.current = tl;

      ScrollTrigger.create({
        trigger: wrapper,
        start: 'top bottom',
        end: 'bottom top',
        onUpdate: (self) => {
          const velocity = self.getVelocity();
          const variation = Math.abs(velocity) / 10000;
          const normalizedVelocity = velocity < 0 ? -variation : variation;
          tl.timeScale(normalizedVelocity);
        },
      });

      ScrollTrigger.create({
        trigger: wrapper,
        start: 'top 90%',
        onEnter: () => gsap.set(galleryInner, { opacity: 1 }),
        onLeaveBack: () => gsap.set(galleryInner, { opacity: 0 }),
      });
    }, wrapper);

    return () => ctx.revert();
  }, []);

  return (
    <section
      ref={wrapperRef}
      className="horizontal-gallery-wrapper"
      style={{ flexDirection: 'column', padding: '40px 0' }}
    >
      <h2
        style={{
          fontFamily: "'Helvetica Neue', 'PingFang SC', 'Microsoft YaHei', sans-serif",
          fontSize: 'clamp(32px, 3vw, 48px)',
          fontWeight: 600,
          lineHeight: 1.2,
          letterSpacing: '-0.5px',
          color: '#FFFFFF',
          marginBottom: '40px',
          textAlign: 'center',
          position: 'absolute',
          top: '40px',
          left: 0,
          right: 0,
          zIndex: 10,
          textShadow: '0 2px 20px rgba(0,0,0,0.5)',
        }}
      >
        机械臂主厨的拿手菜
      </h2>
      <div className="gallery__inner" ref={innerRef} data-image-count={DISH_IMAGES.length} />
    </section>
  );
}
