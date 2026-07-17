using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjeAPI.Data;
namespace ProjeAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MekanlarController : ControllerBase
    {
        private readonly AppDbContext _context;

        public MekanlarController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetMekanlar()
        {
            var mekanlar = await _context.Mekanlar.AsNoTracking().ToListAsync();
            return Ok(mekanlar);
        }

        [HttpGet("ara/{sehir}")]
        public async Task<IActionResult> SehireGoreAra(string sehir)
        {
            if (string.IsNullOrWhiteSpace(sehir))
            {
                return BadRequest("Şehir parametresi boş olamaz.");
            }
            var mekanlar = await _context.Mekanlar
                .AsNoTracking()
                .Where(m => m.Sehir.ToLower() == sehir.ToLower())
                .ToListAsync();

            return Ok(mekanlar);
        }
    }
}