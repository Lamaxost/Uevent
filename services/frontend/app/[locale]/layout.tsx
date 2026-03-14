import type { Metadata } from 'next'
import { NextIntlClientProvider } from 'next-intl'
import { getMessages } from 'next-intl/server'
import { Geist } from 'next/font/google'
import { notFound } from 'next/navigation'

import { SITE_DESCRIPTION, SITE_NAME } from '@/constants/seo.constants'

import './globals.css'
import { Providers } from './providers'

const geistSans = Geist({
	variable: '--font-geist-sans'
})

export const metadata: Metadata = {
	title: {
		absolute: SITE_NAME,
		template: `%s | ${SITE_NAME}`
	},
	description: SITE_DESCRIPTION
}

export function generateStaticParams() {
	return [
		{ locale: 'en' },
		{ locale: 'pl' },
		{ locale: 'ua' },
		{ locale: 'al' }
	]
}

export default async function RootLayout({
	children,
	params
}: Readonly<{
	children: React.ReactNode
	params: Promise<{ locale: string }>
}>) {
	const { locale } = await params
	let messages

	try {
		messages = await getMessages({ locale })
	} catch {
		notFound()
	}

	return (
		<html lang={locale}>
			<body className={`${geistSans.variable} font-sans`}>
				<NextIntlClientProvider locale={locale} messages={messages}>
					<Providers>{children}</Providers>
				</NextIntlClientProvider>
			</body>
		</html>
	)
}
