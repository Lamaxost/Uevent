import createMiddleware from 'next-intl/middleware'

export default createMiddleware({
	locales: ['pl', 'ua', 'en', 'al'],
	defaultLocale: 'en'
})

export const config = {
	matcher: ['/', '/(en|pl|ua|al)/:path*']
}
