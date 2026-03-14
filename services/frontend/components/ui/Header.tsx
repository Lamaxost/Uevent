import next from 'next'
import { useTranslations } from 'next-intl'
import Image from 'next/image'

import { PUBLIC_URL } from '@/config/url.config'

import { HeaderProps } from '@/shared/types/HeaderVariant'

import Logo from '@/assets/Logo6.png'
import AccountIcon from '@/assets/icons/account-icon.svg'
import SearchIcon from '@/assets/icons/search-icon.svg'
import { Link } from '@/i18n/navigation'

export default function Header({ variant = 'default' }: HeaderProps) {
	const t = useTranslations('Header')

	return (
		<header className=' bg-blue-600'>
			<div
				className={`flex flex-col px-12 ${
					variant === 'default' ? 'h-58' : 'h-28 '
				}`}
			>
				<div
					className={`flex justify-between ${variant === 'default' ? '' : 'items-center h-full'} `}
				>
					<div
						className={`flex  ${variant === 'default' ? 'items-center h-22' : 'items-center h-full'}`}
					>
						<Link href={PUBLIC_URL.home()}>
							<Image
								src={Logo}
								alt='Eventify Logo'
								width={160}
								height={40}
								className='-mt-2'
							/>
						</Link>

						<nav className='ml-8 h-full'>
							<ul className='flex text-white text-xl ml-8 h-full items-center '>
								<li className='px-4 hover:bg-[#2b40b9] h-full'>
									<Link
										href={PUBLIC_URL.music()}
										className='font-semibold h-full flex items-center'
									>
										{t('Music')}
									</Link>
								</li>
								<li className='px-4 hover:bg-[#2b40b9] h-full'>
									<Link
										href={PUBLIC_URL.festivals()}
										className='font-semibold h-full flex items-center'
									>
										{t('Festivals')}
									</Link>
								</li>
								<li className='px-4 hover:bg-[#2b40b9] h-full'>
									<Link
										href={PUBLIC_URL.sport()}
										className='font-semibold h-full flex items-center'
									>
										{t('Sport')}
									</Link>
								</li>
								<li className='px-4 hover:bg-[#2b40b9] h-full'>
									<Link
										href={PUBLIC_URL.clubs()}
										className='font-semibold h-full flex items-center'
									>
										{t('Clubs')}
									</Link>
								</li>
								<li className='px-4 hover:bg-[#2b40b9] h-full'>
									<Link
										href={PUBLIC_URL.specialEvents()}
										className='font-semibold h-full flex items-center'
									>
										{t('SpecialEvents')}
									</Link>
								</li>
								<li className='px-4 hover:bg-[#2b40b9] h-full'>
									<Link
										href={PUBLIC_URL.standUp()}
										className='font-semibold h-full flex items-center'
									>
										{t('StandUp')}
									</Link>
								</li>
								<li className='px-4 hover:bg-[#2b40b9] h-full'>
									<Link
										href={PUBLIC_URL.artAndTheater()}
										className='font-semibold h-full flex items-center'
									>
										{t('ArtTheater')}
									</Link>
								</li>
								<li className='px-4 hover:bg-[#2b40b9] h-full '>
									<Link
										href={PUBLIC_URL.family()}
										className='font-semibold h-full flex items-center'
									>
										{t('Family')}
									</Link>
								</li>
							</ul>
						</nav>
					</div>

					<div
						className={`flex  ${variant === 'default' ? 'items-center h-22' : 'items-center h-full '} hover:bg-[#2b40b9] px-4`}
					>
						<Link
							href={PUBLIC_URL.profile()}
							className='flex items-center'
						>
							<Image
								src={AccountIcon}
								alt='Account Icon'
								width={32}
								height={32}
							/>
							<span className='text-white font-semibold text-xl pl-2'>
								{t('MyAccount')}
							</span>
						</Link>
					</div>
				</div>

				{variant === 'default' && (
					<div className='flex justify-center mt-5'>
						<div className='bg-white flex items-center p-1.5 px-3 gap-1.5 rounded-md w-1/2'>
							<div className='border-r-2 border-[#cfcfcf] h-full'>
								vd
							</div>
							<div className='p-1 flex items-center gap-2 w-full focus-within:ring-2 focus-within:ring-blue-600'>
								<div className='relative w-7 h-7'>
									<Image src={SearchIcon} alt='search' fill />
								</div>
								<div className='flex flex-col w-full'>
									<label
										htmlFor='search'
										className='text-[14px]'
									>
										{t('Search').toUpperCase()}
									</label>
									<input
										type='text'
										id='search'
										placeholder={t('SearchPlaceholder')}
										className='border-none h-8 placeholder:text-gray-500 placeholder:font-medium focus:outline-none focus:ring-0'
									/>
								</div>
							</div>
							<button className='bg-blue-600 text-white py-2 px-5 rounded hover:bg-blue-700 font-semibold text-xl'>
								{t('Search')}
							</button>
						</div>
					</div>
				)}
			</div>
		</header>
	)
}
