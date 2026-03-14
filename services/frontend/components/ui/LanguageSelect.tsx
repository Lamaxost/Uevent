'use client'

import Image from 'next/image'
import { useParams, usePathname, useRouter } from 'next/navigation'
import { useEffect, useState } from 'react'

import { Button } from '@/components/ui/Button'
import {
	Sheet,
	SheetContent,
	SheetHeader,
	SheetTitle,
	SheetTrigger
} from '@/components/ui/Sheet'

const languages = [
	{ code: 'en', name: 'English', flag: '/flags/us.webp' },
	{ code: 'pl', name: 'Polski', flag: '/flags/pl.webp' },
	{ code: 'ua', name: 'Ukraine', flag: '/flags/ua.webp' },
	{ code: 'al', name: 'Albanian', flag: '/flags/al.webp' }
]

export default function LanguageSelect() {
	const [isOpen, setIsOpen] = useState(false)

	const pathname = usePathname()
	const router = useRouter()
	const params = useParams()

	const currentLocale = params.locale as string

	const currentLanguage =
		languages.find(lang => lang.code === currentLocale) || languages[0]

	useEffect(() => {}, [currentLocale])

	function changeLanguage(locale: string) {
		const segments = pathname.split('/')
		segments[1] = locale
		router.push(segments.join('/'))
	}

	return (
		<Sheet open={isOpen} onOpenChange={setIsOpen}>
			<SheetTrigger>
				<Button
					variant='link'
					className='text-white flex items-center gap-2 hover:cursor-pointer'
				>
					<div className='w-6 h-6 relative rounded-full border border-gray-500'>
						<Image
							src={currentLanguage.flag}
							alt={currentLanguage.name}
							fill
							className='object-cover p-px rounded-full'
						/>
					</div>
					<span className='text-[16px] font-medium mt-0.5'>
						{currentLanguage.code.toUpperCase()}
					</span>
				</Button>
			</SheetTrigger>

			<SheetContent side='left'>
				<SheetHeader>
					<SheetTitle className='text-2xl'>Language</SheetTitle>
				</SheetHeader>

				<div className='flex flex-col mt-8'>
					{languages.map(lang => (
						<button
							key={lang.code}
							onClick={() => {
								changeLanguage(lang.code)
								setIsOpen(false)
							}}
							className='hover:bg-[#f6f6f6] hover:cursor-pointer h-12 group'
						>
							<div className='flex items-center gap-3 ml-10 h-8'>
								<div className='w-5 h-5 relative rounded-full border border-gray-500'>
									<Image
										src={lang.flag}
										alt={lang.name}
										fill
										className='object-cover p-px rounded-full'
									/>
								</div>

								<span className='text-xl group-hover:underline'>
									{lang.name}
								</span>
							</div>
						</button>
					))}
				</div>
			</SheetContent>
		</Sheet>
	)
}
