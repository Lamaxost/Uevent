'use client'

import Image from 'next/image'

import Header from '@/components/ui/Header'
import LanguageSelect from '@/components/ui/LanguageSelect'

import { PUBLIC_URL } from '@/config/url.config'

import { Link } from '@/i18n/navigation'

const events = [
	{
		id: 1,
		title: 'Ariana Grande Concert',
		date: '2023-10-15',
		location: 'Warsaw',
		imageUrl:
			'https://www.vogue.pl/uploads/repository/00000000_1_zdjecie_nowe/arimain.jpg'
	},
	{
		id: 2,
		title: 'Coldplay Live',
		date: '2023-11-20',
		location: 'Krakow',
		imageUrl:
			'https://www.vogue.pl/uploads/repository/00000000_1_zdjecie_nowe/arimain.jpg'
	},
	{
		id: 3,
		title: 'Ed Sheeran Tour',
		date: '2023-12-05',
		location: 'Gdansk',
		imageUrl:
			'https://www.vogue.pl/uploads/repository/00000000_1_zdjecie_nowe/arimain.jpg'
	},
	{
		id: 4,
		title: 'Beyoncé Live',
		date: '2024-01-10',
		location: 'Wroclaw',
		imageUrl:
			'https://www.vogue.pl/uploads/repository/00000000_1_zdjecie_nowe/arimain.jpg'
	}
]

export default function Home() {
	return (
		<>
			<div className='w-full h-12 bg-[#121212] flex items-center justify-start px-9'>
				<div className='flex items-center'>
					<LanguageSelect />
				</div>
			</div>

			<Header />

			<section>
				<Link
					href={PUBLIC_URL.event()}
					className='relative block w-full h-[58vh] min-h-96 max-h-192 overflow-hidden shadow-xl/30'
				>
					<Image
						src='https://www.vogue.pl/uploads/repository/00000000_1_zdjecie_nowe/arimain.jpg'
						alt='Event Image'
						fill
						className='object-cover'
					/>
					<div className='absolute inset-0 bg-linear-to-t from-black/65 via-black/25 to-transparent' />
					<div className='absolute bottom-8 left-6 z-10 space-y-4 md:bottom-14 md:left-24'>
						<h2 className='text-white text-4xl font-bold underline'>
							Ariana Grande Concert
						</h2>
						<p className='text-white text-2xl'>
							2023-10-15 Warshawa
						</p>
						<button className='mt-2 px-4 py-2 bg-blue-600 text-white rounded text-xl'>
							Find Tickets
						</button>
					</div>
				</Link>
			</section>

			<section className='grid grid-cols-[5fr_1.2fr] gap-2 ml-6 items-start'>
				<div className=' grid grid-cols-2 mt-6'>
					{events.map(event => (
						<div key={event.id} className='px-4 pb-6 '>
							<Link href='' className='block w-full group'>
								<div className='relative w-full h-95 transition-shadow duration-300 group-hover:shadow-xl '>
									<Image
										src={event.imageUrl}
										alt={event.title}
										fill
										className='object-cover rounded-md'
									/>
									<div className='absolute inset-0 bg-blue-700/20 rounded-md opacity-0 group-hover:opacity-100 transition-opacity' />
								</div>
								<div className='flex flex-col'>
									<p className='text-md pt-2 text-[#727272] font-medium'>
										{event.location.toUpperCase()} -{' '}
										{event.date}
									</p>
									<h3 className='text-lg font-semibold group-hover:underline transition-all duration-100 group-hover:text-blue-600'>
										{event.title}
									</h3>
								</div>
							</Link>
						</div>
					))}
				</div>
				<div className='mr-6 z-20'>
					<div className='w-full flex justify-center flex-col shadow-2xl'>
						<div className='pt-60 w-full'>
							<h2 className='text-center pb-2 text-xl font-extralight'>
								advertisement
							</h2>
							<hr className='w-full' />
						</div>
						<div className='mt-6 mx-4'>
							<div className='w-10 h-1 bg-black' />
							<h2 className='pt-2 font-bold text-2xl'>
								WE PRESENT
							</h2>
							<div className='flex flex-col gap-4 mt-4'>
								{events.map(event => (
									<Link
										key={event.id}
										href=''
										className='block w-full group'
									>
										<div className='relative w-full h-45 transition-shadow duration-300 group-hover:shadow-xl '>
											<Image
												src={event.imageUrl}
												alt={event.title}
												fill
												className='object-cover rounded-md'
											/>
											<div className='absolute inset-0 bg-blue-700/20 rounded-md opacity-0 group-hover:opacity-100 transition-opacity' />
										</div>
										<h3 className='text-lg font-semibold mt-2 group-hover:underline transition-all duration-100 group-hover:text-blue-600'>
											{event.title}
										</h3>
									</Link>
								))}
							</div>
						</div>
					</div>
				</div>
			</section>
		</>
	)
}
