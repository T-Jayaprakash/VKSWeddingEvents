/* ========================================================================
   VKS Wedding Design Studio — Minimal Interactions
   Only: fade, slide-up, soft-scale | 400-600ms | cubic-bezier(0.16,1,0.3,1)
   ======================================================================== */

document.addEventListener('DOMContentLoaded', () => {
  // ── Preloader ──
  const preloader = document.getElementById('preloader');
  if (preloader) {
    window.addEventListener('load', () => {
      setTimeout(() => preloader.classList.add('loaded'), 400);
    });
    // Fallback
    setTimeout(() => preloader.classList.add('loaded'), 3000);
  }

  // ── Navbar Scroll ──
  const navbar = document.getElementById('navbar');
  if (navbar) {
    const onScroll = () => {
      navbar.classList.toggle('scrolled', window.scrollY > 60);
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  // ── Mobile Menu ──
  const menuToggle = document.getElementById('menuToggle');
  const mobileMenu = document.getElementById('mobileMenuOverlay');
  if (menuToggle && mobileMenu) {
    menuToggle.addEventListener('click', () => {
      menuToggle.classList.toggle('active');
      mobileMenu.classList.toggle('active');
      document.body.style.overflow = mobileMenu.classList.contains('active') ? 'hidden' : '';
    });
    mobileMenu.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        menuToggle.classList.remove('active');
        mobileMenu.classList.remove('active');
        document.body.style.overflow = '';
      });
    });
  }

  // ── Scroll Reveal ──
  const revealEls = document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .reveal-scale');
  if (revealEls.length && 'IntersectionObserver' in window) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });
    revealEls.forEach(el => observer.observe(el));
  } else {
    revealEls.forEach(el => el.classList.add('visible'));
  }

  // ── Back to Top ──
  const backToTop = document.getElementById('backToTop');
  if (backToTop) {
    window.addEventListener('scroll', () => {
      backToTop.classList.toggle('visible', window.scrollY > 600);
    }, { passive: true });
    backToTop.addEventListener('click', () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // ── Gallery Lightbox (supports .masonry-item and .gallery-item) ──
  const galleryItems = document.querySelectorAll('.masonry-item, .gallery-item');
  const lightbox = document.getElementById('lightbox');
  const lightboxImg = document.getElementById('lightboxImg');
  const lightboxClose = document.getElementById('lightboxClose');
  const lightboxPrev = document.getElementById('lightboxPrev');
  const lightboxNext = document.getElementById('lightboxNext');
  let currentIndex = 0;
  const images = [];

  if (galleryItems.length && lightbox) {
    galleryItems.forEach((item, i) => {
      const img = item.querySelector('img');
      if (img) {
        images.push({ src: img.src, alt: img.alt });
        item.addEventListener('click', () => openLightbox(i));
      }
    });

    function openLightbox(index) {
      currentIndex = index;
      lightboxImg.src = images[index].src;
      lightboxImg.alt = images[index].alt;
      lightbox.classList.add('active');
      document.body.style.overflow = 'hidden';
    }

    function closeLightbox() {
      lightbox.classList.remove('active');
      document.body.style.overflow = '';
    }

    function navigate(dir) {
      currentIndex = (currentIndex + dir + images.length) % images.length;
      lightboxImg.src = images[currentIndex].src;
      lightboxImg.alt = images[currentIndex].alt;
    }

    if (lightboxClose) lightboxClose.addEventListener('click', closeLightbox);
    if (lightboxPrev) lightboxPrev.addEventListener('click', () => navigate(-1));
    if (lightboxNext) lightboxNext.addEventListener('click', () => navigate(1));

    lightbox.addEventListener('click', (e) => {
      if (e.target === lightbox) closeLightbox();
    });

    document.addEventListener('keydown', (e) => {
      if (!lightbox.classList.contains('active')) return;
      if (e.key === 'Escape') closeLightbox();
      if (e.key === 'ArrowLeft') navigate(-1);
      if (e.key === 'ArrowRight') navigate(1);
    });
  }

  // ── Contact Form → WhatsApp ──
  const contactForm = document.getElementById('contactForm');
  if (contactForm) {
    const formError = document.getElementById('formError');

    function showError(msg) {
      if (!formError) return;
      formError.textContent = msg;
      formError.style.display = 'block';
      formError.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    function hideError() {
      if (formError) formError.style.display = 'none';
    }

    contactForm.addEventListener('submit', (e) => {
      e.preventDefault();
      hideError();

      const name = contactForm.querySelector('[name="name"]')?.value.trim() || '';
      const phone = contactForm.querySelector('[name="phone"]')?.value.trim() || '';
      const date = contactForm.querySelector('[name="eventDate"]')?.value.trim() || '';
      const venue = contactForm.querySelector('[name="venue"]')?.value.trim() || '';
      const service = contactForm.querySelector('[name="service"]')?.value.trim() || '';
      const budget = contactForm.querySelector('[name="budget"]')?.value.trim() || '';
      const note = contactForm.querySelector('[name="message"]')?.value.trim() || '';

      // Validation
      if (!name) return showError('Please enter your full name.');
      if (!phone) return showError('Please enter your phone number.');
      if (!date) return showError('Please select your event date.');
      if (!venue) return showError('Please enter your venue name.');
      if (!service) return showError('Please select a service.');

      // Format date nicely
      let displayDate = date;
      try {
        displayDate = new Date(date).toLocaleDateString('en-IN', { day: 'numeric', month: 'long', year: 'numeric' });
      } catch (_) { }

      const message =
        `Hello VKS Garland and Decorations,

I would like to enquire about your wedding decoration services.

--- Customer Details ---
Name  : ${name}
Phone : ${phone}

--- Event Details ---
Event Date : ${displayDate}
Venue      : ${venue}

--- Service Requested ---
Service      : ${service}
Budget Range : ${budget || 'Not specified'}

--- Additional Message ---
${note || 'No additional message provided.'}

Please let me know about your availability and pricing.

Thank you.`;

      const encoded = encodeURIComponent(message);
      window.open(`https://wa.me/919789567567?text=${encoded}`, '_blank');
    });
  }

  // ── Lazy Loading ──
  if ('loading' in HTMLImageElement.prototype) {
    document.querySelectorAll('img[loading="lazy"]').forEach(img => {
      img.src = img.src;
    });
  }
});
