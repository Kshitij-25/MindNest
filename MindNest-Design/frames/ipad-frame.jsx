/* iPad Pro 11" portrait device frame — uniform bezel, no notch.
   Logical screen: 834 × 1194. Exports: IPadDevice, IPadStatusBar */

function IPadStatusBar({ dark = false, time = '9:41' }) {
  const c = dark ? '#fff' : '#1F2519';
  return (
    <div style={{
      position: 'absolute', top: 0, left: 0, right: 0, height: 28, zIndex: 30,
      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      padding: '0 30px', pointerEvents: 'none',
      fontFamily: '-apple-system, "SF Pro Text", system-ui',
    }}>
      <span style={{ fontSize: 15, fontWeight: 600, color: c, letterSpacing: 0.2 }}>{time}</span>
      <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
        {/* wifi */}
        <svg width="18" height="13" viewBox="0 0 18 13"><path d="M9 11.2 9 11.2M2 5.2a10 10 0 0 1 14 0M4.6 7.6a6.3 6.3 0 0 1 8.8 0M9 10.4a1.4 1.4 0 1 0 0 .01" stroke={c} strokeWidth="1.5" fill="none" strokeLinecap="round"/></svg>
        {/* battery */}
        <svg width="27" height="13" viewBox="0 0 27 13">
          <rect x="0.5" y="0.5" width="23" height="12" rx="3.4" stroke={c} strokeOpacity="0.4" fill="none"/>
          <rect x="2" y="2" width="17" height="9" rx="2" fill={c}/>
          <path d="M25 4.5V8.5C25.8 8.2 26.5 7.2 26.5 6.5C26.5 5.8 25.8 4.8 25 4.5Z" fill={c} fillOpacity="0.4"/>
        </svg>
      </div>
    </div>
  );
}

function IPadDevice({ children, width = 834, height = 1194, dark = false }) {
  const bezel = 22;
  return (
    <div style={{
      width: width + bezel * 2, height: height + bezel * 2, borderRadius: 46,
      background: dark ? '#0A0C08' : '#0E110B',
      padding: bezel, boxSizing: 'border-box', position: 'relative',
      boxShadow: '0 50px 100px rgba(31,40,24,0.22), 0 0 0 1px rgba(0,0,0,0.18), inset 0 0 0 2px rgba(255,255,255,0.04)',
    }}>
      {/* front camera */}
      <div style={{
        position: 'absolute', top: bezel / 2 - 3, left: '50%', transform: 'translateX(-50%)',
        width: 7, height: 7, borderRadius: '50%', background: '#1A1F16',
        boxShadow: 'inset 0 0 0 1.5px rgba(255,255,255,0.06)', zIndex: 60,
      }} />
      <div style={{
        width: '100%', height: '100%', borderRadius: 26, overflow: 'hidden',
        position: 'relative', background: 'var(--bg)',
      }}>
        <IPadStatusBar dark={dark} />
        <div style={{ position: 'absolute', top: 28, left: 0, right: 0, bottom: 0 }}>{children}</div>
        {/* home indicator */}
        <div style={{
          position: 'absolute', bottom: 7, left: '50%', transform: 'translateX(-50%)',
          width: 320, height: 5, borderRadius: 100, zIndex: 60, pointerEvents: 'none',
          background: dark ? 'rgba(255,255,255,0.5)' : 'rgba(31,37,25,0.28)',
        }} />
      </div>
    </div>
  );
}

Object.assign(window, { IPadDevice, IPadStatusBar });
