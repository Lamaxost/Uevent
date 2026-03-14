import type { NextConfig } from 'next'
import createNextIntlPlugin from 'next-intl/plugin'

const nextConfig: NextConfig = {
	env: {
		APP_ENV: process.env.APP_ENV,
		APP_URL: process.env.APP_URL,
		APP_DOMAIN: process.env.APP_DOMAIN,
		SERVER_URL: process.env.SERVER_URL
	},
	images: {
		remotePatterns: [
			{
				protocol: 'https',
				hostname: 'lh3.googleusercontent.com'
			},
			{
				protocol: 'https',
				hostname: 'www.vogue.pl'
			}
		]
	},
	webpack(config) {
		const fileLoaderRule = config.module.rules.find((rule: any) =>
			rule.test?.test?.('.svg')
		)

		config.module.rules.push(
			{
				...fileLoaderRule,
				test: /\.svg$/i,
				resourceQuery: /url/
			},
			{
				test: /\.svg$/i,
				issuer: /\.[jt]sx?$/,
				resourceQuery: { not: /url/ },
				use: [
					{
						loader: '@svgr/webpack',
						options: {
							svgo: false,
							titleProp: true,
							ref: true
						}
					}
				]
			}
		)

		if (fileLoaderRule) {
			fileLoaderRule.exclude = /\.svg$/i
		}

		return config
	},
	async rewrites() {
		return [
			{
				source: '/uploads/:path*',
				destination: `${process.env.SERVER_URL}/uploads/:path*`
			}
		]
	}
}

const withNextIntl = createNextIntlPlugin()
export default withNextIntl(nextConfig)
