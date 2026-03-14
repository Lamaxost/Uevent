import { hasLocale } from 'next-intl'
import { getRequestConfig } from 'next-intl/server'

const locales = ['pl', 'ua', 'en', 'al'] as const
const defaultLocale = 'en'

export default getRequestConfig(async ({ requestLocale }) => {
	const localeFromRoute = await requestLocale
	const locale = hasLocale(locales, localeFromRoute)
		? localeFromRoute
		: defaultLocale

	return {
		locale,
		messages: (await import(`../messages/${locale}.json`)).default
	}
})
